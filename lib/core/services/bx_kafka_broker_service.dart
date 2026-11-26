// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_broker_service.dart
// Architecture: Core Layer - Bx Kafka Broker Service
// Purpose: Own the app's broker connection: one authenticated event stream per
//          conversation, reconnect with backoff and resume, duplicate/ordering
//          protection by `seq`, presence snapshots, and the publish path.
//
// How the connection works
// ------------------------
// A mobile app cannot be a Kafka client: there is no Dart Kafka protocol
// implementation, the broker is not reachable from the public internet, and
// SASL/TLS material must never ship inside an app bundle. The Tayara API owns
// the broker: it persists a message, publishes it to
// `tayara.support.chat.messages.v1`, consumes the topic on every replica and
// fans the record out over `GET /api/v1/support/conversations/:id/stream`.
//
// This service is therefore the client half of that bridge:
//   * read  — an SSE stream fed by Kafka, replayed from MySQL via `sinceSeq`.
//   * write — `POST /api/v1/support/conversations/:id/messages` with a
//             `clientMsgId`, so retries are idempotent server-side.

library;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/core/services/bx_kafka_config.dart';
import 'package:tayara/core/services/bx_kafka_connection_state.dart';
import 'package:tayara/core/services/bx_kafka_event.dart';
import 'package:tayara/core/services/bx_kafka_sse_parser.dart';
import 'package:tayara/core/services/bx_kafka_stream_transport.dart';

/// Outcome of publishing a message through the API (which then publishes to
/// Kafka).
class BxKafkaPublishResult {
  /// Creates a publish result.
  const BxKafkaPublishResult({
    required this.success,
    this.code,
    this.message,
    this.messageUuid,
    this.seq,
    this.clientMsgId,
    this.messageId,
  });

  /// Whether the API accepted and persisted the message.
  final bool success;

  /// Envelope code returned by the API (`0` means success).
  final int? code;

  /// Failure reason, or the API's message.
  final String? message;

  /// `message_uuid` of the persisted record, when returned.
  final String? messageUuid;

  /// Dense per-conversation sequence assigned by the API.
  final int? seq;

  /// Client id echoed back for optimistic reconciliation.
  final String? clientMsgId;

  /// Database id of the message row, when returned.
  final int? messageId;

  @override
  String toString() =>
      'BxKafkaPublishResult(success: $success, code: $code, seq: $seq, '
      'message: $message)';
}

/// Client for the Kafka-backed support transport.
///
/// Lifecycle: call [connect] when a conversation screen becomes visible and
/// [disconnect] when it is disposed. The service keeps the highest `seq` per
/// conversation, so a later [connect] resumes exactly where the last one
/// stopped.
class BxKafkaBrokerService {
  /// Creates the service.
  ///
  /// [tokenProvider] defaults to the token stored on [BxAppData.currentUser],
  /// which is the same X-token every other authenticated call uses.
  BxKafkaBrokerService({
    BxKafkaConfig? config,
    BxKafkaStreamTransport? transport,
    BxDioClient? dioClient,
    String? Function()? tokenProvider,
  }) : _config = config ?? BxKafkaConfig.fromEnvironment(),
       _dioClient = dioClient ?? BxDioClient.instance,
       _tokenProvider = tokenProvider ?? _defaultTokenProvider {
    _transport =
        transport ??
        BxKafkaStreamTransport(
          config: _config,
          tokenProvider: () => _tokenProvider(),
        );
  }

  static String? _defaultTokenProvider() => BxAppData.currentUser?.data?.token;

  final BxKafkaConfig _config;
  final BxDioClient _dioClient;
  final String? Function() _tokenProvider;

  late final BxKafkaStreamTransport _transport;

  final StreamController<BxKafkaEvent> _events =
      StreamController<BxKafkaEvent>.broadcast();
  final StreamController<BxKafkaPresenceChanged> _presenceChanges =
      StreamController<BxKafkaPresenceChanged>.broadcast();
  final StreamController<BxKafkaConnectionState> _states =
      StreamController<BxKafkaConnectionState>.broadcast();

  final Map<int, _BxConversationConnection> _connections =
      <int, _BxConversationConnection>{};
  final Map<int, int> _lastSeq = <int, int>{};
  final Map<String, BxKafkaPresenceChanged> _presence =
      <String, BxKafkaPresenceChanged>{};
  final Map<int, BxKafkaConnectionState> _statesByConversation =
      <int, BxKafkaConnectionState>{};

  bool _disposed = false;

  /// Effective configuration (useful for diagnostics).
  BxKafkaConfig get config => _config;

  /// Every record received from any tracked conversation.
  Stream<BxKafkaEvent> get events => _events.stream;

  /// Only `message.created` records.
  Stream<BxKafkaEvent> get messages =>
      _events.stream.where((event) => event.isMessage);

  /// Only `presence.changed` transitions.
  Stream<BxKafkaPresenceChanged> get presenceChanges => _presenceChanges.stream;

  /// Connection transitions for every tracked conversation.
  Stream<BxKafkaConnectionState> get connectionStates => _states.stream;

  /// Conversations currently tracked.
  Iterable<int> get trackedConversations =>
      _connections.keys.toList(growable: false);

  /// Highest accepted `seq` for [conversationId], `0` when none.
  int lastSeqOf(int conversationId) => _lastSeq[conversationId] ?? 0;

  /// Latest known connection state for [conversationId].
  BxKafkaConnectionState stateOf(int conversationId) {
    return _statesByConversation[conversationId] ??
        BxKafkaConnectionState(
          status: BxKafkaConnectionStatus.idle,
          conversationId: conversationId,
        );
  }

  /// Whether [conversationId] has an open, authorised stream.
  bool isConnected(int conversationId) =>
      stateOf(conversationId).status == BxKafkaConnectionStatus.connected;

  /// Latest known presence for one actor, or `null` when never observed.
  BxKafkaPresenceChanged? presenceOf(String actorType, int actorId) =>
      _presence['$actorType:$actorId'];

  /// Opens (or keeps) the stream for [conversationId].
  ///
  /// [sinceSeq] overrides the resume point. When omitted the service resumes
  /// from the highest `seq` it has already delivered, which is what makes a
  /// reconnect gap-free without any extra bookkeeping in the UI.
  Future<void> connect(int conversationId, {int? sinceSeq}) async {
    if (_disposed || conversationId <= 0) return;

    if (!_config.enabled) {
      final disabled = _connection(conversationId);
      _setState(
        disabled,
        BxKafkaConnectionStatus.disabled,
        error: 'The Kafka transport is disabled in configuration.',
      );
      return;
    }

    final existing = _connections[conversationId];
    if (existing != null &&
        !existing.stopped &&
        (existing.status == BxKafkaConnectionStatus.connected ||
            existing.status == BxKafkaConnectionStatus.connecting)) {
      return;
    }

    final connection = existing ?? _connection(conversationId);

    // A manual connect wins over a scheduled reopen. Without this the pending
    // timer fires after `_open` has already started a fresh reader, and the
    // conversation ends up with two subscriptions fighting over one stream.
    connection.reconnectTimer?.cancel();
    connection.reconnectTimer = null;
    connection.heartbeatTimer?.cancel();
    connection.heartbeatTimer = null;
    final pendingSubscription = connection.subscription;
    connection.subscription = null;
    await pendingSubscription?.cancel();
    await _transport.close(conversationId);

    connection.stopped = false;
    connection.attempt = 0;
    connection.resumeFrom = sinceSeq ?? _lastSeq[conversationId];
    await _open(connection);
  }

  /// Closes the stream for [conversationId] and stops reconnecting.
  ///
  /// The last delivered `seq` is retained so a later [connect] resumes.
  Future<void> disconnect(int conversationId) async {
    final connection = _connections[conversationId];
    if (connection == null) return;
    connection.stopped = true;
    connection.reconnectTimer?.cancel();
    connection.reconnectTimer = null;
    connection.heartbeatTimer?.cancel();
    connection.heartbeatTimer = null;
    final subscription = connection.subscription;
    connection.subscription = null;
    await subscription?.cancel();
    await _transport.close(conversationId);
    _setState(connection, BxKafkaConnectionStatus.closed);
  }

  /// Publishes a message for [conversationId].
  ///
  /// The API persists the message **before** it publishes to Kafka and returns
  /// the persisted record, so a successful result means the message exists even
  /// if the broker is down. [clientMsgId] must be stable across retries: the
  /// API's `uk_client_msg` unique index makes a repeat request idempotent.
  Future<BxKafkaPublishResult> publishMessage({
    required int conversationId,
    required String body,
    required String clientMsgId,
    List<String> attachmentUuids = const <String>[],
  }) async {
    if (conversationId <= 0) {
      return const BxKafkaPublishResult(
        success: false,
        code: 400,
        message: 'A conversation id is required.',
      );
    }
    if (clientMsgId.trim().isEmpty) {
      return const BxKafkaPublishResult(
        success: false,
        code: 400,
        message: 'A client message id is required for idempotent sending.',
      );
    }
    if (body.trim().isEmpty && attachmentUuids.isEmpty) {
      return const BxKafkaPublishResult(
        success: false,
        code: 400,
        message: 'A message needs text or at least one attachment.',
      );
    }

    final token = _tokenProvider();
    if (token == null || token.isEmpty) {
      return const BxKafkaPublishResult(
        success: false,
        code: 401,
        message: 'You need to sign in before sending a message.',
      );
    }

    try {
      final raw = await _dioClient.post(
        _config.messagesPath(conversationId),
        data: <String, dynamic>{
          'body': body,
          if (attachmentUuids.isNotEmpty) 'attachmentUuids': attachmentUuids,
          'clientMsgId': clientMsgId,
        },
        options: Options(
          headers: <String, String>{'x-token': token},
          receiveTimeout: _config.restTimeout,
          sendTimeout: _config.restTimeout,
        ),
      );

      final envelope = raw is Map
          ? raw.map((key, value) => MapEntry(key.toString(), value))
          : <String, dynamic>{};
      final code = _asInt(envelope['code']) ?? 0;
      final message =
          envelope['msg']?.toString() ?? envelope['message']?.toString();

      if (code != 0) {
        return BxKafkaPublishResult(
          success: false,
          code: code,
          message: message ?? 'The message could not be sent.',
          clientMsgId: clientMsgId,
        );
      }

      final data = envelope['data'];
      final payload = data is Map
          ? data.map((key, value) => MapEntry(key.toString(), value))
          : <String, dynamic>{};
      final nested = payload['message'];
      final record = nested is Map
          ? nested.map((key, value) => MapEntry(key.toString(), value))
          : payload;

      return BxKafkaPublishResult(
        success: true,
        code: 0,
        message: message,
        messageUuid: (record['messageUuid'] ?? record['message_uuid'])
            ?.toString(),
        seq: _asInt(record['seq']),
        messageId: _asInt(record['id'] ?? record['messageId']),
        clientMsgId:
            (record['clientMsgId'] ?? record['client_msg_id'])?.toString() ??
            clientMsgId,
      );
    } on DioException catch (error) {
      return BxKafkaPublishResult(
        success: false,
        code: error.response?.statusCode,
        message: _publishError(error),
        clientMsgId: clientMsgId,
      );
    } catch (error) {
      return BxKafkaPublishResult(
        success: false,
        code: 500,
        message: 'Failed to send the message: $error',
        clientMsgId: clientMsgId,
      );
    }
  }

  /// Releases every stream, timer and controller.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    for (final conversationId in _connections.keys.toList(growable: false)) {
      await disconnect(conversationId);
    }
    await _transport.closeAll();
    await _events.close();
    await _presenceChanges.close();
    await _states.close();
  }

  // -------------------------------------------------------------------------
  // Internals
  // -------------------------------------------------------------------------

  _BxConversationConnection _connection(int conversationId) {
    return _connections.putIfAbsent(
      conversationId,
      () => _BxConversationConnection(conversationId),
    );
  }

  Future<void> _open(_BxConversationConnection connection) async {
    if (_disposed || connection.stopped || !_config.enabled) return;
    connection.attempt += 1;
    _setState(
      connection,
      connection.attempt <= 1
          ? BxKafkaConnectionStatus.connecting
          : BxKafkaConnectionStatus.reconnecting,
    );

    try {
      final frames = await _transport.open(
        conversationId: connection.conversationId,
        sinceSeq: connection.resumeFrom,
      );
      if (connection.stopped) {
        await _transport.close(connection.conversationId);
        return;
      }
      _setState(connection, BxKafkaConnectionStatus.connected);
      _armHeartbeat(connection);
      connection.subscription = frames.listen(
        (frame) => _onFrame(connection, frame),
        onError: (Object error, StackTrace stackTrace) =>
            _onStreamEnded(connection, error),
        onDone: () => _onStreamEnded(connection, null),
        cancelOnError: true,
      );
    } catch (error) {
      _onStreamEnded(connection, error);
    }
  }

  void _onFrame(_BxConversationConnection connection, BxKafkaSseFrame frame) {
    // Any byte from the API — including a heartbeat comment — proves liveness.
    _armHeartbeat(connection);

    if (frame.isComment) return;

    if (frame.isClosing) {
      connection.stopped = true;
      _setState(
        connection,
        BxKafkaConnectionStatus.closed,
        error: 'The server closed the stream.',
      );
      unawaited(_transport.close(connection.conversationId));
      return;
    }

    if (!frame.hasData) return;

    final event = BxKafkaEvent.tryParse(
      frame.data,
      sseId: frame.id,
      fallbackEventType: frame.event,
    );
    if (event == null) {
      debugPrint(
        'BxKafkaBrokerService: dropped an unsupported frame '
        '(event: ${frame.event}, id: ${frame.id}).',
      );
      return;
    }

    // A decoded record means the connection is healthy; reset the backoff.
    if (connection.attempt != 0) connection.attempt = 0;
    connection.lastEventId = event.resumeId;

    if (event.isPresence) {
      final presence = BxKafkaPresenceChanged.fromEvent(event);
      _presence[presence.actorKey] = presence;
      if (!_presenceChanges.isClosed) _presenceChanges.add(presence);
      if (!_events.isClosed) _events.add(event);
      return;
    }

    final seq = event.seq;
    final conversationId = event.conversationId ?? connection.conversationId;
    if (seq != null) {
      final known = _lastSeq[conversationId] ?? 0;
      if (seq <= known) {
        // Replay after a reconnect overlaps what we already have.
        return;
      }
      _lastSeq[conversationId] = seq;
      connection.resumeFrom = seq;
    }

    if (!_events.isClosed) _events.add(event);
  }

  void _onStreamEnded(_BxConversationConnection connection, Object? error) {
    connection.heartbeatTimer?.cancel();
    connection.heartbeatTimer = null;
    final subscription = connection.subscription;
    connection.subscription = null;
    unawaited(subscription?.cancel());
    unawaited(_transport.close(connection.conversationId));

    if (_disposed || connection.stopped) return;

    final failure = error is BxKafkaStreamTransportException ? error : null;

    if (failure?.isAuthFailure ?? false) {
      connection.stopped = true;
      _setState(
        connection,
        BxKafkaConnectionStatus.unauthorized,
        error: failure!.message,
      );
      return;
    }

    if (connection.attempt >= _config.maxReconnectAttempts) {
      connection.stopped = true;
      _setState(
        connection,
        BxKafkaConnectionStatus.failed,
        error: _describe(error) ?? 'The support stream could not be restored.',
      );
      return;
    }

    _setState(
      connection,
      BxKafkaConnectionStatus.reconnecting,
      error: _describe(error),
    );

    connection.reconnectTimer?.cancel();
    connection.reconnectTimer = Timer(
      _config.retry.delayFor(connection.attempt),
      () => _open(connection),
    );
  }

  void _armHeartbeat(_BxConversationConnection connection) {
    connection.heartbeatTimer?.cancel();
    connection.heartbeatTimer = Timer(_config.heartbeatTimeout, () {
      _onStreamEnded(
        connection,
        BxKafkaStreamTransportException(
          message:
              'No heartbeat for ${_config.heartbeatTimeout.inSeconds}s; '
              'reopening the stream.',
        ),
      );
    });
  }

  void _setState(
    _BxConversationConnection connection,
    BxKafkaConnectionStatus status, {
    String? error,
  }) {
    connection.status = status;
    connection.lastError = error;
    connection.updatedAt = DateTime.now();
    final snapshot = BxKafkaConnectionState(
      status: status,
      conversationId: connection.conversationId,
      attempt: connection.attempt,
      lastEventId: connection.lastEventId,
      error: error,
      updatedAt: connection.updatedAt,
    );
    _statesByConversation[connection.conversationId] = snapshot;
    if (!_states.isClosed) _states.add(snapshot);
    debugPrint('BxKafkaBrokerService: ${snapshot.toString()}');
  }

  String? _describe(Object? error) {
    if (error == null) return null;
    if (error is BxKafkaStreamTransportException) return error.message;
    return error.toString();
  }

  String _publishError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return 'The message timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      default:
        final status = error.response?.statusCode;
        if (status == 401) return 'Your session expired. Please sign in again.';
        if (status == 403) {
          return 'You are not allowed to write to this conversation.';
        }
        if (status == 409) {
          return 'That message was already sent.';
        }
        if (status == 429) return 'You are sending too fast. Please slow down.';
        return error.message ?? 'The message could not be sent.';
    }
  }

  int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim());
    return null;
  }
}

/// Mutable per-conversation bookkeeping. Never exposed outside this library.
class _BxConversationConnection {
  _BxConversationConnection(this.conversationId);

  final int conversationId;

  BxKafkaConnectionStatus status = BxKafkaConnectionStatus.idle;
  int attempt = 0;
  int? resumeFrom;
  String? lastEventId;
  String? lastError;
  DateTime updatedAt = DateTime.now();
  bool stopped = false;

  StreamSubscription<BxKafkaSseFrame>? subscription;
  Timer? reconnectTimer;
  Timer? heartbeatTimer;
}
