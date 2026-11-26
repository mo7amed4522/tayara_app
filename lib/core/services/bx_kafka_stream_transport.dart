// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_stream_transport.dart
// Architecture: Core Layer - Bx Kafka Stream Transport
// Purpose: Open the HTTP event stream that the Tayara API feeds from Kafka,
//          authenticate it, decode SSE frames and expose cancellation.
//
// This is the only place in the app that touches the wire for the broker
// bridge. It has its own Dio instance on purpose: a long-lived stream must not
// inherit the REST client's 30s receive timeout or its interceptors.

library;

// ignore_for_file: prefer_initializing_formals

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:tayara/core/services/bx_kafka_config.dart';
import 'package:tayara/core/services/bx_kafka_sse_parser.dart';

/// Failure while opening or reading the event stream.
class BxKafkaStreamTransportException implements Exception {
  /// Creates a transport failure.
  const BxKafkaStreamTransportException({
    required this.message,
    this.statusCode,
    this.retryable = true,
  });

  /// Human-readable reason.
  final String message;

  /// HTTP status code, when the failure came from the handshake.
  final int? statusCode;

  /// Whether retrying the same request could succeed.
  final bool retryable;

  /// Whether the API rejected the credentials.
  bool get isAuthFailure => statusCode == 401 || statusCode == 403;

  @override
  String toString() => 'BxKafkaStreamTransportException($statusCode): $message';
}

/// Opens and decodes `text/event-stream` responses for one conversation.
///
/// A conversation may have at most one live stream: opening it again cancels
/// the previous one, so a reconnect can never leave a zombie reader behind.
class BxKafkaStreamTransport {
  /// Creates a transport.
  ///
  /// [tokenProvider] must return the current X-token; the stream is
  /// authenticated per connection, so a refreshed token is picked up on the
  /// next reconnect without any extra wiring.
  BxKafkaStreamTransport({
    required this.config,
    Dio? dio,
    String? Function()? tokenProvider,
  }) : _tokenProvider = tokenProvider {
    _dio =
        dio ??
        Dio(
          BaseOptions(
            baseUrl: config.baseUrl,
            connectTimeout: config.connectTimeout,
            // A stream is quiet by design: only the heartbeat watchdog decides
            // that a connection is dead.
            receiveTimeout: null,
            sendTimeout: null,
            validateStatus: (status) => status != null && status < 500,
          ),
        );
  }

  /// Client configuration (origin, timeouts, topics).
  final BxKafkaConfig config;

  final String? Function()? _tokenProvider;
  late final Dio _dio;
  final Map<int, CancelToken> _tokens = <int, CancelToken>{};

  /// Whether a stream is currently tracked for [conversationId].
  bool isOpen(int conversationId) {
    final token = _tokens[conversationId];
    return token != null && !token.isCancelled;
  }

  /// Number of tracked streams.
  int get openCount => _tokens.length;

  /// Opens the stream for [conversationId].
  ///
  /// [sinceSeq] makes the API replay missed records from MySQL before it
  /// resumes the live fanout, which is how a reconnect avoids gaps.
  Future<Stream<BxKafkaSseFrame>> open({
    required int conversationId,
    int? sinceSeq,
  }) async {
    if (conversationId <= 0) {
      throw const BxKafkaStreamTransportException(
        message: 'A positive conversation id is required to open a stream.',
        retryable: false,
      );
    }

    final token = _tokenProvider?.call();
    if (token == null || token.isEmpty) {
      throw const BxKafkaStreamTransportException(
        message: 'Missing authentication token for the support stream.',
        statusCode: 401,
        retryable: false,
      );
    }

    // Never keep two readers on the same conversation.
    await close(conversationId);

    final cancelToken = CancelToken();
    _tokens[conversationId] = cancelToken;

    Response<dynamic> response;
    try {
      response = await _dio.get<dynamic>(
        config.streamPath(conversationId),
        queryParameters: <String, dynamic>{
          if (sinceSeq != null && sinceSeq > 0) 'sinceSeq': sinceSeq,
        },
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.stream,
          headers: <String, String>{
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
            // The backend reads the customer token from X-token.
            'x-token': token,
          },
        ),
      );
    } on DioException catch (error) {
      _tokens.remove(conversationId);
      throw _mapDioError(error);
    } catch (error) {
      _tokens.remove(conversationId);
      throw BxKafkaStreamTransportException(
        message: 'Could not open the support stream: $error',
      );
    }

    final status = response.statusCode ?? 0;
    if (status != 200) {
      _tokens.remove(conversationId);
      throw BxKafkaStreamTransportException(
        message: _messageForStatus(status),
        statusCode: status,
        retryable: status >= 500,
      );
    }

    final body = response.data;
    if (body is! ResponseBody) {
      _tokens.remove(conversationId);
      throw const BxKafkaStreamTransportException(
        message: 'The support stream returned an unexpected response body.',
        statusCode: 200,
      );
    }

    return _decode(body.stream);
  }

  /// Cancels the stream for [conversationId], if any.
  Future<void> close(int conversationId) async {
    final token = _tokens.remove(conversationId);
    if (token != null && !token.isCancelled) {
      token.cancel('stream closed by client');
    }
  }

  /// Cancels every tracked stream.
  Future<void> closeAll() async {
    for (final conversationId in _tokens.keys.toList(growable: false)) {
      await close(conversationId);
    }
  }

  /// Decodes bytes into frames, preserving multi-byte characters that are
  /// split across network chunks by decoding the byte stream first.
  Stream<BxKafkaSseFrame> _decode(Stream<Uint8List> bytes) async* {
    final parser = BxKafkaSseParser();
    final lines = bytes
        .cast<List<int>>()
        .transform(utf8.decoder)
        .transform(const LineSplitter());
    await for (final line in lines) {
      for (final frame in parser.addLine(line)) {
        yield frame;
      }
    }
    for (final frame in parser.flush()) {
      yield frame;
    }
  }

  BxKafkaStreamTransportException _mapDioError(DioException error) {
    final status = error.response?.statusCode;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return BxKafkaStreamTransportException(
          message: 'Timed out while connecting to the support stream.',
          statusCode: status,
        );
      case DioExceptionType.connectionError:
        return BxKafkaStreamTransportException(
          message: 'No internet connection. Please check your network.',
          statusCode: status,
        );
      case DioExceptionType.badResponse:
        return BxKafkaStreamTransportException(
          message: _messageForStatus(status ?? 0),
          statusCode: status,
          retryable: status == null || status >= 500,
        );
      case DioExceptionType.cancel:
        return BxKafkaStreamTransportException(
          message: 'The support stream was cancelled.',
          statusCode: status,
          retryable: false,
        );
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.unknown:
        return BxKafkaStreamTransportException(
          message: error.message ?? 'The support stream failed.',
          statusCode: status,
        );
    }
  }

  String _messageForStatus(int status) {
    switch (status) {
      case 401:
        return 'Your session expired. Please sign in again.';
      case 403:
        return 'You are not allowed to read this conversation.';
      case 404:
        return 'This conversation does not exist.';
      case 429:
        return 'Too many open streams. Please try again shortly.';
      default:
        if (status >= 500) {
          return 'The support service is unavailable right now.';
        }
        return 'The support stream failed (HTTP $status).';
    }
  }
}
