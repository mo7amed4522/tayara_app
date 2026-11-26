// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_event_bus.dart
// Architecture: Core Layer - Bx Kafka Event Bus
// Purpose: The single subscription surface for UI/state layers: route broker
//          events by type or conversation, and read presence snapshots.

library;

import 'dart:async';

import 'package:tayara/core/services/bx_kafka_broker_service.dart';
import 'package:tayara/core/services/bx_kafka_connection_state.dart';
import 'package:tayara/core/services/bx_kafka_event.dart';

/// Convenience facade over [BxKafkaBrokerService].
///
/// BLoCs and screens depend on this instead of the broker service so that the
/// transport can be swapped (or faked in tests) without touching the UI layer.
/// The bus adds no buffering: listeners attach before [track] is called when
/// they need every event.
class BxKafkaEventBus {
  /// Creates a bus backed by [broker].
  BxKafkaEventBus(this.broker);

  /// Underlying transport owner.
  final BxKafkaBrokerService broker;

  /// Conversations this bus started, and therefore may stop.
  final Set<int> _tracked = <int>{};

  /// Conversations this bus is responsible for.
  Set<int> get trackedConversations => Set<int>.unmodifiable(_tracked);

  /// Every record from every tracked conversation.
  Stream<BxKafkaEvent> get events => broker.events;

  /// Only `message.created` records.
  Stream<BxKafkaEvent> get messages => broker.messages;

  /// Only `presence.changed` transitions.
  Stream<BxKafkaPresenceChanged> get presenceChanges => broker.presenceChanges;

  /// Connection transitions.
  Stream<BxKafkaConnectionState> get connectionStates =>
      broker.connectionStates;

  /// Records of one [eventType], e.g. `BxKafkaEventType.ticketAssigned`.
  Stream<BxKafkaEvent> on(String eventType) =>
      broker.events.where((event) => event.eventType == eventType);

  /// Records for one conversation, optionally narrowed to [eventTypes].
  Stream<BxKafkaEvent> forConversation(
    int conversationId, {
    Set<String>? eventTypes,
  }) {
    return broker.events.where(
      (event) =>
          event.conversationId == conversationId &&
          (eventTypes == null || eventTypes.contains(event.eventType)),
    );
  }

  /// Latest connection state of [conversationId].
  BxKafkaConnectionState stateOf(int conversationId) =>
      broker.stateOf(conversationId);

  /// Whether [conversationId] is currently live.
  bool isConnected(int conversationId) => broker.isConnected(conversationId);

  /// Highest accepted `seq` for [conversationId].
  int lastSeqOf(int conversationId) => broker.lastSeqOf(conversationId);

  /// Latest observed presence for an actor.
  BxKafkaPresenceChanged? presenceOf(String actorType, int actorId) =>
      broker.presenceOf(actorType, actorId);

  /// Whether [actorId] of [actorType] is currently online.
  ///
  /// `unknown` is reported as `false`: treating it as offline would show a
  /// misleading dot whenever the API's presence store is unavailable.
  bool isOnline(String actorType, int actorId) =>
      broker.presenceOf(actorType, actorId)?.isOnline ?? false;

  /// Starts tracking [conversationId].
  Future<void> track(int conversationId, {int? sinceSeq}) {
    _tracked.add(conversationId);
    return broker.connect(conversationId, sinceSeq: sinceSeq);
  }

  /// Stops tracking [conversationId].
  Future<void> untrack(int conversationId) {
    _tracked.remove(conversationId);
    return broker.disconnect(conversationId);
  }

  /// Subscribes [onEvent] to one conversation and returns the subscription.
  ///
  /// The caller owns the subscription and must cancel it in `dispose`.
  StreamSubscription<BxKafkaEvent> listen(
    int conversationId,
    void Function(BxKafkaEvent event) onEvent, {
    Set<String>? eventTypes,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return forConversation(
      conversationId,
      eventTypes: eventTypes,
    ).listen(onEvent, onError: onError);
  }

  /// Stops the conversations this bus started.
  ///
  /// The broker service is a shared singleton: other screens, tabs or
  /// features may hold live conversations on it, so this never disposes it or
  /// closes their streams. Only [BxKafkaBrokerService.dispose] may do that, and
  /// only when the app itself is shutting down.
  Future<void> dispose() async {
    final conversations = _tracked.toList(growable: false);
    _tracked.clear();
    for (final conversationId in conversations) {
      await broker.disconnect(conversationId);
    }
  }
}
