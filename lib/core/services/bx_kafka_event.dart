// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_event.dart
// Architecture: Core Layer - Bx Kafka Event
// Purpose: Parse the versioned v1 envelope the API publishes to Kafka and
//          re-emits over the HTTP event stream.

library;

import 'dart:convert';

/// The `event_type` values carried by the v1 envelope.
///
/// The names are part of the wire contract; treat them as constants, never as
/// strings invented at a call site.
abstract final class BxKafkaEventType {
  /// A message was appended to a conversation and persisted.
  static const String messageCreated = 'message.created';

  /// A support ticket (and its conversation) was opened.
  static const String ticketOpened = 'ticket.opened';

  /// A ticket was assigned or redirected to an employee.
  static const String ticketAssigned = 'ticket.assigned';

  /// A quality reviewer recorded a verdict.
  static const String ticketReviewed = 'ticket.reviewed';

  /// A customer voted on a FAQ option.
  static const String faqVoted = 'faq.voted';

  /// A participant connected or disconnected (transitions only).
  static const String presenceChanged = 'presence.changed';

  /// The bridge closed the stream on purpose (server shutdown / revocation).
  static const String closing = 'closing';

  /// Highest envelope version this client understands.
  static const int maxSupportedSchemaVersion = 1;
}

/// Presence states reported by the API.
abstract final class BxKafkaPresenceState {
  /// At least one live connection exists.
  static const String online = 'online';

  /// No live connection exists.
  static const String offline = 'offline';

  /// The API could not decide (Redis unavailable). Never treated as offline.
  static const String unknown = 'unknown';
}

/// Metadata for one file attached to a message.
///
/// Bytes never travel through the broker: only this descriptor does. The file
/// is fetched from the gated download endpoint by [uuid].
class BxKafkaAttachment {
  /// Creates an attachment descriptor.
  const BxKafkaAttachment({
    required this.uuid,
    this.kind,
    this.mimeType,
    this.sizeBytes,
    this.originalName,
    this.width,
    this.height,
    this.thumbnailUuid,
  });

  /// Stable identifier used by the download endpoint.
  final String uuid;

  /// `image` or `file`.
  final String? kind;

  /// Sniffed MIME type agreed with the extension server-side.
  final String? mimeType;

  /// Stored size in bytes.
  final int? sizeBytes;

  /// Sanitised original file name.
  final String? originalName;

  /// Pixel width for images.
  final int? width;

  /// Pixel height for images.
  final int? height;

  /// Reserved for thumbnails; always `null` in v1.
  final String? thumbnailUuid;

  /// Whether the attachment is an image.
  bool get isImage => kind == 'image';

  /// Parses an attachment descriptor from a `message.created` payload.
  factory BxKafkaAttachment.fromJson(Map<String, dynamic> json) {
    return BxKafkaAttachment(
      uuid: (json['attachment_uuid'] ?? json['attachmentUuid'] ?? '')
          .toString(),
      kind: _string(json['kind']),
      mimeType: _string(json['mime_type'] ?? json['mimeType']),
      sizeBytes: _int(json['size_bytes'] ?? json['sizeBytes']),
      originalName: _string(json['original_name'] ?? json['originalName']),
      width: _int(json['width']),
      height: _int(json['height']),
      thumbnailUuid: _string(json['thumbnail_uuid'] ?? json['thumbnailUuid']),
    );
  }

  @override
  String toString() => 'BxKafkaAttachment($uuid, $kind, $mimeType)';
}

/// A `presence.changed` record, keyed by actor.
class BxKafkaPresenceChanged {
  /// Creates a presence transition.
  const BxKafkaPresenceChanged({
    required this.actorType,
    required this.actorId,
    required this.state,
    this.previousState,
    this.lastSeenAt,
    this.lastSeenVisible = true,
    this.conversationId,
    this.ticketId,
    this.occurredAt,
  });

  /// `customer`, `support`, `quality` or `admin`.
  final String actorType;

  /// `bx_user_profile.id` for customers, `sys_admin_profile.id` otherwise.
  final int actorId;

  /// New state: [BxKafkaPresenceState].
  final String state;

  /// State this transition replaced.
  final String? previousState;

  /// Server clock value for the last activity, hidden roles report `null`.
  final DateTime? lastSeenAt;

  /// `false` when the API suppressed last-seen for this actor's role.
  final bool lastSeenVisible;

  /// Conversation the frame was routed for, when present.
  final int? conversationId;

  /// Ticket the conversation belongs to, when present.
  final int? ticketId;

  /// When the transition happened.
  final DateTime? occurredAt;

  /// `actor_type:actor_id`, the key used by the presence snapshot map.
  String get actorKey => '$actorType:$actorId';

  /// Whether the actor is currently reachable.
  bool get isOnline => state == BxKafkaPresenceState.online;

  /// Builds the transition from an envelope carrying `presence.changed`.
  factory BxKafkaPresenceChanged.fromEvent(BxKafkaEvent event) {
    final data = event.data;
    return BxKafkaPresenceChanged(
      actorType: _string(data['actor_type'] ?? data['actorType']) ?? 'unknown',
      actorId: _int(data['actor_id'] ?? data['actorId']) ?? 0,
      state: _string(data['state']) ?? BxKafkaPresenceState.unknown,
      previousState: _string(data['previous_state'] ?? data['previousState']),
      lastSeenAt: DateTime.tryParse(
        (data['last_seen_at'] ?? data['lastSeenAt'] ?? '').toString(),
      ),
      lastSeenVisible:
          _bool(data['last_seen_visible'] ?? data['lastSeenVisible']) ?? true,
      conversationId: event.conversationId,
      ticketId: event.ticketId,
      occurredAt: event.occurredAt,
    );
  }

  @override
  String toString() =>
      'BxKafkaPresenceChanged($actorKey, $previousState -> $state)';
}

/// One record from the Kafka topic, as re-emitted by the API's event stream.
///
/// The envelope is versioned and additive-only. A record whose
/// `schema_version` is greater than
/// [BxKafkaEventType.maxSupportedSchemaVersion] is rejected by [tryParse]
/// instead of being guessed at, matching the backend consumer contract.
class BxKafkaEvent {
  /// Creates an event.
  const BxKafkaEvent({
    required this.eventType,
    required this.schemaVersion,
    this.eventId = '',
    this.occurredAt,
    this.conversationId,
    this.ticketId,
    this.data = const <String, dynamic>{},
    this.sseId,
    this.offset,
  });

  /// `message.created`, `presence.changed`, … See [BxKafkaEventType].
  final String eventType;

  /// Envelope version, `1` today.
  final int schemaVersion;

  /// Producer-assigned unique id, used for exactly-once bookkeeping.
  final String eventId;

  /// When the producing service created the record.
  final DateTime? occurredAt;

  /// Conversation the record belongs to (the broker message key).
  final int? conversationId;

  /// Ticket the conversation belongs to.
  final int? ticketId;

  /// Event-specific payload, already decoded.
  final Map<String, dynamic> data;

  /// `id:` field of the stream frame, if the bridge supplied one.
  final String? sseId;

  /// Broker offset, when the fanout stamped it on the payload.
  final int? offset;

  /// Dense per-conversation sequence number, the ordering authority.
  int? get seq => _int(data['seq']);

  /// `message_uuid` of a `message.created` record.
  String? get messageUuid =>
      _string(data['message_uuid'] ?? data['messageUuid']);

  /// `customer`, `support`, `quality` or `system`.
  String? get senderType => _string(data['sender_type'] ?? data['senderType']);

  /// Identifier of the sender inside its own domain.
  int? get senderId => _int(data['sender_id'] ?? data['senderId']);

  /// Sanitised plain-text body.
  String? get body => _string(data['body']);

  /// Client id echoed back for optimistic-send reconciliation.
  String? get clientMsgId =>
      _string(data['client_msg_id'] ?? data['clientMsgId']);

  /// Attachments riding this message; empty (never null) for text-only.
  List<BxKafkaAttachment> get attachments {
    final raw = data['attachments'];
    if (raw is! List) return const <BxKafkaAttachment>[];
    return raw
        .whereType<Map<dynamic, dynamic>>()
        .map((item) => BxKafkaAttachment.fromJson(_asMap(item)))
        .toList(growable: false);
  }

  /// Whether this record is a new chat message.
  bool get isMessage => eventType == BxKafkaEventType.messageCreated;

  /// Whether this record is a presence transition.
  bool get isPresence => eventType == BxKafkaEventType.presenceChanged;

  /// Whether this record belongs to the ticket/channel families.
  bool get isTicketEvent => eventType.startsWith('ticket.');

  /// Marker to send as `sinceSeq` when reconnecting.
  ///
  /// Prefers the frame id supplied by the bridge, then the conversation/seq
  /// pair, then the producer's event id — all three are accepted by the API.
  String get resumeId {
    if (sseId != null && sseId!.isNotEmpty) return sseId!;
    final sequence = seq;
    if (sequence != null && conversationId != null) {
      return '$conversationId:$sequence';
    }
    return eventId;
  }

  /// Parses [raw] and returns `null` when it is not a usable v1 event.
  ///
  /// [sseId] is the `id:` field of the frame, [fallbackEventType] the `event:`
  /// field, used when the payload itself omits `event_type`.
  static BxKafkaEvent? tryParse(
    Object? raw, {
    String? sseId,
    String? fallbackEventType,
  }) {
    Map<String, dynamic>? json;
    if (raw is Map) {
      json = _asMap(raw);
    } else if (raw is String) {
      final text = raw.trim();
      if (text.isEmpty) return null;
      try {
        final decoded = jsonDecode(text);
        if (decoded is Map) json = _asMap(decoded);
      } catch (_) {
        return null;
      }
    }
    if (json == null) return null;

    final version = _int(json['schema_version'] ?? json['schemaVersion']) ?? 1;
    if (version > BxKafkaEventType.maxSupportedSchemaVersion) return null;

    final type =
        _string(json['event_type'] ?? json['eventType']) ??
        _string(fallbackEventType);
    if (type == null || type.isEmpty) return null;

    final payload = json['data'];
    return BxKafkaEvent(
      eventType: type,
      schemaVersion: version,
      eventId: _string(json['event_id'] ?? json['eventId']) ?? '',
      occurredAt: DateTime.tryParse(
        (json['occurred_at'] ?? json['occurredAt'] ?? '').toString(),
      ),
      conversationId: _int(json['conversation_id'] ?? json['conversationId']),
      ticketId: _int(json['ticket_id'] ?? json['ticketId']),
      data: payload is Map ? _asMap(payload) : const <String, dynamic>{},
      sseId: sseId,
      offset: _int(json['kafka_offset'] ?? json['offset']),
    );
  }

  /// Re-encodes the envelope, mainly for logging and tests.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'schema_version': schemaVersion,
    'event_id': eventId,
    if (occurredAt != null) 'occurred_at': occurredAt!.toIso8601String(),
    'event_type': eventType,
    if (conversationId != null) 'conversation_id': conversationId,
    if (ticketId != null) 'ticket_id': ticketId,
    'data': data,
  };

  @override
  String toString() =>
      'BxKafkaEvent($eventType, conversation: $conversationId, seq: $seq)';
}

// ---------------------------------------------------------------------------
// Decoding helpers
// ---------------------------------------------------------------------------

Map<String, dynamic> _asMap(Map<dynamic, dynamic> source) {
  if (source is Map<String, dynamic>) return source;
  return source.map((key, value) => MapEntry(key.toString(), value));
}

int? _int(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim());
  return null;
}

String? _string(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

bool? _bool(Object? value) {
  if (value is bool) return value;
  if (value is String) {
    final lower = value.toLowerCase();
    if (lower == 'true') return true;
    if (lower == 'false') return false;
  }
  return null;
}
