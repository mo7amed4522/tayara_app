// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_config.dart
// Architecture: Core Layer - Bx Kafka Configuration
// Purpose: Resolve every setting the Kafka transport needs (bridge origin,
//          topics, timeouts, retry policy) from `.env` with safe defaults.
//
// IMPORTANT: a mobile binary must never hold a Kafka broker address, SASL
// credential or TLS material. The app does not dial the broker. It talks to
// the Tayara API, which owns the broker and fans Kafka records out over an
// HTTP event stream. Every key below is therefore a *client* setting only.

library;

import 'dart:math' as math;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/network/bx_api_endpoints.dart';

/// Kafka topic names used by the Tayara API `support` module.
///
/// The names mirror `support.kafka.topics` in the backend configuration so a
/// log line, a metric label or a debugging session reads the same on both
/// sides. The app never publishes to or consumes from a topic directly; it only
/// tags the records it receives with the topic they came from.
class BxKafkaTopics {
  /// Creates a topic set, defaulting to the backend's v1 names.
  const BxKafkaTopics({
    this.chatMessages = defaultChatMessages,
    this.chatEvents = defaultChatEvents,
    this.presence = defaultPresence,
    this.chatMessagesDlq = defaultChatMessagesDlq,
  });

  /// `message.created` records, keyed by conversation id in the broker.
  static const String defaultChatMessages = 'tayara.support.chat.messages.v1';

  /// `ticket.opened`, `ticket.assigned`, `ticket.reviewed`, `faq.voted`.
  static const String defaultChatEvents = 'tayara.support.chat.events.v1';

  /// `presence.changed` transitions only (never heartbeats).
  static const String defaultPresence = 'tayara.support.presence.v1';

  /// Dead-letter topic; the app only mirrors the name for diagnostics.
  static const String defaultChatMessagesDlq =
      'tayara.support.chat.messages.dlq.v1';

  /// Topic carrying `message.created` records.
  final String chatMessages;

  /// Topic carrying ticket lifecycle events.
  final String chatEvents;

  /// Topic carrying presence transitions.
  final String presence;

  /// Topic carrying records the API could not process.
  final String chatMessagesDlq;

  /// Reads the topic names from the environment, keeping the backend defaults.
  factory BxKafkaTopics.fromEnvironment(String? Function(String key) read) {
    return BxKafkaTopics(
      chatMessages: read('KAFKA_CHAT_MESSAGES_TOPIC') ?? defaultChatMessages,
      chatEvents: read('KAFKA_CHAT_EVENTS_TOPIC') ?? defaultChatEvents,
      presence: read('KAFKA_PRESENCE_TOPIC') ?? defaultPresence,
      chatMessagesDlq:
          read('KAFKA_CHAT_MESSAGES_DLQ_TOPIC') ?? defaultChatMessagesDlq,
    );
  }

  /// Returns the topic that owns [eventType], or `null` when unknown.
  String? topicFor(String eventType) {
    switch (eventType) {
      case 'message.created':
        return chatMessages;
      case 'presence.changed':
        return presence;
      case 'ticket.opened':
      case 'ticket.assigned':
      case 'ticket.reviewed':
      case 'faq.voted':
        return chatEvents;
      default:
        return null;
    }
  }

  @override
  String toString() =>
      'BxKafkaTopics(chatMessages: $chatMessages, chatEvents: $chatEvents, '
      'presence: $presence, dlq: $chatMessagesDlq)';
}

/// Capped exponential backoff used when the event stream has to be re-opened.
///
/// The values are deliberately smaller than the backend's producer backoff:
/// a mobile radio reconnect should feel instant, while a broker outage should
/// not spin. [delayFor] is deterministic so the behaviour is unit-testable.
class BxKafkaRetryPolicy {
  /// Creates a retry policy.
  const BxKafkaRetryPolicy({
    this.initialDelay = const Duration(milliseconds: 750),
    this.maxDelay = const Duration(seconds: 30),
    this.multiplier = 2,
  });

  /// Delay before the first retry.
  final Duration initialDelay;

  /// Upper bound for any single delay.
  final Duration maxDelay;

  /// Growth factor applied per attempt.
  final double multiplier;

  /// Returns the delay to wait before reconnect attempt [attempt].
  ///
  /// [attempt] is zero-based: `0` returns [initialDelay].
  Duration delayFor(int attempt) {
    if (attempt <= 0) return initialDelay;
    final raw =
        initialDelay.inMilliseconds * math.pow(multiplier, attempt).toDouble();
    final capped = math.min(raw, maxDelay.inMilliseconds.toDouble());
    return Duration(milliseconds: capped.round());
  }

  /// Reads the retry settings from the environment.
  factory BxKafkaRetryPolicy.fromEnvironment(String? Function(String) read) {
    return BxKafkaRetryPolicy(
      initialDelay: Duration(
        milliseconds: _asInt(read('KAFKA_RETRY_INITIAL_MS')) ?? 750,
      ),
      maxDelay: Duration(
        seconds: _asInt(read('KAFKA_RETRY_MAX_SECONDS')) ?? 30,
      ),
      multiplier: (_asInt(read('KAFKA_RETRY_MULTIPLIER')) ?? 2).toDouble(),
    );
  }
}

/// Immutable configuration for [BxKafkaBrokerService].
class BxKafkaConfig {
  /// Creates a configuration.
  const BxKafkaConfig({
    required this.baseUrl,
    this.enabled = true,
    this.apiVersion = 'v1',
    this.topics = const BxKafkaTopics(),
    this.restTimeout = const Duration(seconds: 30),
    this.connectTimeout = const Duration(seconds: 30),
    this.heartbeatTimeout = const Duration(seconds: 45),
    this.maxReconnectAttempts = 8,
    this.retry = const BxKafkaRetryPolicy(),
  });

  /// When `false` the app will not open the event stream at all. Sending a
  /// message over REST still works, because that is the producer path and does
  /// not depend on the stream.
  final bool enabled;

  /// Origin of the Tayara API that bridges the broker to this client.
  final String baseUrl;

  /// API version segment (`v1`), matching [BxAppData.appVersion].
  final String apiVersion;

  /// Topic names carried by the bridge.
  final BxKafkaTopics topics;

  /// Timeout for REST calls (publish). The stream has no receive timeout.
  final Duration restTimeout;

  /// Timeout for the stream handshake only.
  final Duration connectTimeout;

  /// A stream that is silent for this long is considered dead and re-opened.
  /// The backend emits a heartbeat comment every 15s, so 45s tolerates two
  /// missed beats before the client gives up.
  final Duration heartbeatTimeout;

  /// Reconnect attempts before the connection is marked [failed].
  final int maxReconnectAttempts;

  /// Backoff between reconnect attempts.
  final BxKafkaRetryPolicy retry;

  /// `{origin}/api/{version}/support`.
  String get rootPath => '$baseUrl/api/$apiVersion/support';

  /// Reading an event stream for [conversationId].
  String streamPath(int conversationId) =>
      '$rootPath/conversations/$conversationId/stream';

  /// Appending and paging messages for [conversationId].
  String messagesPath(int conversationId) =>
      '$rootPath/conversations/$conversationId/messages';

  /// Batch presence read for a list of `actor_type:actor_id` ids.
  String get presencePath => '$rootPath/presence';

  /// Gated attachment download (authorised by uuid, never by path).
  String attachmentPath(String attachmentUuid) =>
      '$rootPath/attachments/$attachmentUuid';

  /// Builds the configuration from `.env`, falling back to the API base URL.
  ///
  /// Missing or blank keys are ignored rather than fatal: the transport must be
  /// able to boot on a machine that has an older `.env` file.
  factory BxKafkaConfig.fromEnvironment({String? baseUrl}) {
    String? read(String key) => _readEnv(key);
    final resolvedBase = _normaliseBaseUrl(
      baseUrl ?? read('KAFKA_STREAM_BASE_URL') ?? BxAppConfig.baseUrl,
    );
    return BxKafkaConfig(
      baseUrl: resolvedBase,
      enabled: _asBool(read('KAFKA_ENABLED')) ?? true,
      apiVersion: read('KAFKA_API_VERSION') ?? BxAppData.appVersion,
      topics: BxKafkaTopics.fromEnvironment(read),
      restTimeout: Duration(
        seconds: _asInt(read('KAFKA_REST_TIMEOUT_SECONDS')) ?? 30,
      ),
      connectTimeout: Duration(
        seconds: _asInt(read('KAFKA_CONNECT_TIMEOUT_SECONDS')) ?? 30,
      ),
      heartbeatTimeout: Duration(
        seconds: _asInt(read('KAFKA_HEARTBEAT_TIMEOUT_SECONDS')) ?? 45,
      ),
      maxReconnectAttempts: _asInt(read('KAFKA_MAX_RECONNECT_ATTEMPTS')) ?? 8,
      retry: BxKafkaRetryPolicy.fromEnvironment(read),
    );
  }

  /// Returns a copy with selected fields replaced.
  BxKafkaConfig copyWith({
    bool? enabled,
    String? baseUrl,
    String? apiVersion,
    BxKafkaTopics? topics,
    Duration? restTimeout,
    Duration? connectTimeout,
    Duration? heartbeatTimeout,
    int? maxReconnectAttempts,
    BxKafkaRetryPolicy? retry,
  }) {
    return BxKafkaConfig(
      enabled: enabled ?? this.enabled,
      baseUrl: baseUrl ?? this.baseUrl,
      apiVersion: apiVersion ?? this.apiVersion,
      topics: topics ?? this.topics,
      restTimeout: restTimeout ?? this.restTimeout,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      heartbeatTimeout: heartbeatTimeout ?? this.heartbeatTimeout,
      maxReconnectAttempts: maxReconnectAttempts ?? this.maxReconnectAttempts,
      retry: retry ?? this.retry,
    );
  }

  @override
  String toString() =>
      'BxKafkaConfig(enabled: $enabled, baseUrl: $baseUrl, '
      'apiVersion: $apiVersion, topics: $topics)';
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Reads a non-empty `.env` value, tolerating an uninitialised dotenv.
String? _readEnv(String key) {
  try {
    if (!dotenv.isInitialized) return null;
    final value = dotenv.env[key];
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  } catch (_) {
    return null;
  }
}

String _normaliseBaseUrl(String value) {
  final trimmed = value.trim();
  return trimmed.endsWith('/')
      ? trimmed.substring(0, trimmed.length - 1)
      : trimmed;
}

int? _asInt(String? value) => value == null ? null : int.tryParse(value);

bool? _asBool(String? value) {
  if (value == null) return null;
  switch (value.toLowerCase()) {
    case 'true':
    case '1':
    case 'yes':
    case 'on':
      return true;
    case 'false':
    case '0':
    case 'no':
    case 'off':
      return false;
    default:
      return null;
  }
}
