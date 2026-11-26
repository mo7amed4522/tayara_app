// ignore_for_file: avoid_print
// TEMPORARY live probe against the locally running Tayara API (go run main.go).
// Reads a customer X-token from .support_probe_token, opens a real Kafka-backed
// conversation stream, publishes through the API and reports what actually
// happens. Deleted after the run.

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tayara/core/services/bx_kafka_broker_service.dart';
import 'package:tayara/core/services/bx_kafka_config.dart';
import 'package:tayara/core/services/bx_kafka_connection_state.dart';
import 'package:tayara/core/services/bx_kafka_event.dart';
import 'package:tayara/core/services/bx_kafka_event_bus.dart';

const String _base = 'http://127.0.0.1:8888';

String get _token => File('.support_probe_token').readAsStringSync().trim();

Dio _raw() => Dio(BaseOptions(validateStatus: (status) => status != null));

Map<String, dynamic> _map(Object? value) =>
    value is Map ? value.map((k, v) => MapEntry(k.toString(), v)) : {};

int? _int(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

void _log(String label, Object? value) => print('PROBE | $label: $value');

void main() {
  setUpAll(() {
    // flutter_test mocks HttpClient with a 400-answering stub; restore sockets.
    HttpOverrides.global = null;
  });

  test('live stream + publish against the support API', () async {
    final token = _token;
    expect(token.isNotEmpty, isTrue, reason: '.support_probe_token is empty');

    final dio = _raw();
    final headers = <String, String>{'x-token': token};

    // ---- 1. find or create a conversation -------------------------------
    int? ticketId;
    int? conversationId;

    final tickets = await dio.get<dynamic>(
      '$_base/api/v1/support/tickets',
      options: Options(headers: headers),
    );
    final ticketsBody = _map(tickets.data);
    _log(
      'GET /support/tickets',
      'http=${tickets.statusCode} code=${ticketsBody['code']}',
    );
    final list = _map(ticketsBody['data'])['list'];
    if (list is List && list.isNotEmpty) {
      ticketId = _int(_map(list.first)['id']);
      _log('existing ticket ids', list.map((t) => _map(t)['id']).toList());
    }

    if (ticketId == null) {
      final created = await dio.post<dynamic>(
        '$_base/api/v1/support/tickets',
        options: Options(headers: headers),
        data: <String, dynamic>{'subject': 'Kafka transport probe'},
      );
      final body = _map(created.data);
      _log(
        'POST /support/tickets',
        'http=${created.statusCode} code=${body['code']} msg=${body['msg']}',
      );
      final data = _map(body['data']);
      ticketId = _int(data['id'] ?? _map(data['ticket'])['id']);
      conversationId = _int(
        _map(data['conversation'])['id'] ??
            _map(_map(data['ticket'])['conversation'])['id'],
      );
    }

    if (conversationId == null && ticketId != null) {
      final detail = await dio.get<dynamic>(
        '$_base/api/v1/support/tickets/$ticketId',
        options: Options(headers: headers),
      );
      final body = _map(detail.data);
      final data = _map(body['data']);
      conversationId = _int(
        _map(data['conversation'])['id'] ??
            _map(_map(data['ticket'])['conversation'])['id'] ??
            data['conversationId'],
      );
      _log(
        'GET /support/tickets/$ticketId',
        'http=${detail.statusCode} code=${body['code']} conversationId=$conversationId',
      );
      if (conversationId == null) {
        _log(
          'ticket detail payload (truncated)',
          '${detail.data}'.substring(0, 700.clamp(0, '${detail.data}'.length)),
        );
      }
    }

    expect(conversationId, isNotNull, reason: 'no conversation id discovered');
    _log('conversation', conversationId);

    // ---- 2. open the stream through the real service --------------------
    final config = BxKafkaConfig(
      enabled: true,
      baseUrl: _base,
      apiVersion: 'v1',
      heartbeatTimeout: const Duration(seconds: 45),
      maxReconnectAttempts: 3,
    );
    final broker = BxKafkaBrokerService(
      config: config,
      tokenProvider: () => token,
    );
    final bus = BxKafkaEventBus(broker);

    final states = <BxKafkaConnectionState>[];
    final stateSub = bus.connectionStates.listen(states.add);

    final int conv = conversationId ?? 0;
    final opened = DateTime.now();
    await broker.connect(conv);
    var waited = Duration.zero;
    while (!broker.isConnected(conv) && waited.inMilliseconds < 20000) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      waited += const Duration(milliseconds: 100);
    }
    _log(
      'stream connect',
      'connected=${broker.isConnected(conv)} after=${DateTime.now().difference(opened).inMilliseconds}ms '
          'states=${states.map((s) => s.status.name).toList()} error=${broker.stateOf(conv).error}',
    );
    expect(
      broker.isConnected(conv),
      isTrue,
      reason: 'stream did not reach connected: ${broker.stateOf(conv)}',
    );

    // ---- 3. publish a message with a clientMsgId ------------------------
    final clientMsgId = 'probe-${DateTime.now().millisecondsSinceEpoch}';
    final eventFuture = bus.events
        .firstWhere(
          (event) =>
              event.isMessage &&
              (event.clientMsgId == clientMsgId ||
                  event.body == 'probe body $clientMsgId'),
        )
        .timeout(const Duration(seconds: 25));

    final sentAt = DateTime.now();
    final publish = await broker.publishMessage(
      conversationId: conv,
      body: 'probe body $clientMsgId',
      clientMsgId: clientMsgId,
    );
    _log(
      'publish',
      'success=${publish.success} code=${publish.code} msg=${publish.message} '
          'messageId=${publish.messageId} messageUuid=${publish.messageUuid} seq=${publish.seq}',
    );

    BxKafkaEvent? delivered;
    Object? deliveryError;
    try {
      delivered = await eventFuture;
    } catch (error) {
      deliveryError = error;
    }
    _log(
      'stream delivery',
      delivered == null
          ? 'NOT RECEIVED ($deliveryError) after ${DateTime.now().difference(sentAt).inMilliseconds}ms'
          : 'received after ${DateTime.now().difference(sentAt).inMilliseconds}ms '
                'type=${delivered.eventType} seq=${delivered.seq} '
                'sender=${delivered.senderType}/${delivered.senderId} '
                'body="${delivered.body}" clientMsgId=${delivered.clientMsgId} '
                'resume=${delivered.resumeId} attachments=${delivered.attachments.length}',
    );

    // ---- 4. idempotency: same clientMsgId twice -------------------------
    final duplicate = await broker.publishMessage(
      conversationId: conv,
      body: 'probe body $clientMsgId',
      clientMsgId: clientMsgId,
    );
    _log(
      'duplicate publish',
      'success=${duplicate.success} code=${duplicate.code} seq=${duplicate.seq} '
          'sameSeqAsFirst=${duplicate.seq == publish.seq}',
    );

    // ---- 5. history paging + resume marker ------------------------------
    final history = await dio.get<dynamic>(
      '$_base/api/v1/support/conversations/$conv/messages',
      options: Options(headers: headers),
      queryParameters: <String, dynamic>{'page': 1, 'pageSize': 5},
    );
    final historyBody = _map(history.data);
    _log(
      'GET messages',
      'http=${history.statusCode} code=${historyBody['code']} keys=${_map(historyBody['data']).keys.toList()}',
    );

    _log('lastSeq', broker.lastSeqOf(conv));

    // ---- 6. unauthorized path -------------------------------------------
    final badBroker = BxKafkaBrokerService(
      config: config,
      tokenProvider: () => 'not-a-jwt',
    );
    await badBroker.connect(conv);
    await Future<void>.delayed(const Duration(seconds: 2));
    _log(
      'bad token connect',
      'status=${badBroker.stateOf(conv).status.name} '
          'error=${badBroker.stateOf(conv).error}',
    );
    await badBroker.dispose();

    // ---- 7. teardown ----------------------------------------------------
    await broker.disconnect(conv);
    _log('after disconnect', broker.stateOf(conv).status.name);
    await stateSub.cancel();
    await bus.dispose();
    await broker.dispose();
  }, timeout: const Timeout(Duration(minutes: 3)));
}
