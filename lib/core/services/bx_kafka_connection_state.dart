// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_connection_state.dart
// Architecture: Core Layer - Bx Kafka Connection State
// Purpose: Describe the lifecycle of one conversation's broker-bridge stream.

library;

/// Lifecycle of a single event stream.
enum BxKafkaConnectionStatus {
  /// Nothing has been attempted yet.
  idle,

  /// The stream handshake is in flight.
  connecting,

  /// The stream is open and authorised.
  connected,

  /// The stream dropped and a backoff is running.
  reconnecting,

  /// The API refused the stream (401/403). Retrying cannot fix this, so the
  /// service stops until credentials change.
  unauthorized,

  /// The stream was closed on purpose, by the client or by the server's
  /// `event: closing` frame. No reconnect follows.
  closed,

  /// Reconnect attempts were exhausted.
  failed,

  /// The transport is switched off in configuration.
  disabled;

  /// Whether the stream is expected to deliver events without intervention.
  bool get isLive =>
      this == BxKafkaConnectionStatus.connected ||
      this == BxKafkaConnectionStatus.reconnecting;

  /// Whether the service will stop on its own and needs an external nudge
  /// (a new login, a settings change, a manual retry).
  bool get isTerminal =>
      this == BxKafkaConnectionStatus.unauthorized ||
      this == BxKafkaConnectionStatus.failed ||
      this == BxKafkaConnectionStatus.disabled ||
      this == BxKafkaConnectionStatus.closed;
}

/// Snapshot of one conversation's connection, emitted on every transition.
class BxKafkaConnectionState {
  /// Creates a state snapshot.
  const BxKafkaConnectionState({
    required this.status,
    required this.conversationId,
    this.attempt = 0,
    this.lastEventId,
    this.error,
    this.updatedAt,
  });

  /// Current lifecycle stage.
  final BxKafkaConnectionStatus status;

  /// Conversation this snapshot belongs to.
  final int conversationId;

  /// Number of consecutive failed attempts in the current backoff cycle.
  final int attempt;

  /// Last resume marker accepted from the stream.
  final String? lastEventId;

  /// Human-readable reason for the last failure, when there is one.
  final String? error;

  /// When the snapshot was produced.
  final DateTime? updatedAt;

  /// Whether the stream is currently delivering.
  bool get isConnected => status == BxKafkaConnectionStatus.connected;

  @override
  String toString() =>
      'BxKafkaConnectionState($conversationId, ${status.name}, '
      'attempt: $attempt, error: $error)';
}
