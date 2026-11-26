// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/services/bx_kafka_sse_parser.dart
// Architecture: Core Layer - Bx Kafka SSE Parser
// Purpose: Incrementally turn `text/event-stream` lines into frames, including
//          heartbeat comment frames and the server's `closing` frame.

library;

/// One dispatched server-sent-event frame.
class BxKafkaSseFrame {
  /// Creates a frame.
  const BxKafkaSseFrame({
    this.event,
    this.id,
    this.data,
    this.retryMs,
    this.comment,
  });

  /// `event:` field — the event type, when the bridge sets it.
  final String? event;

  /// `id:` field — the resume marker.
  final String? id;

  /// Joined `data:` lines.
  final String? data;

  /// `retry:` field in milliseconds.
  final int? retryMs;

  /// Payload of a `:` comment line, used for the 15s heartbeat.
  final String? comment;

  /// Whether this frame is a keep-alive comment rather than an event.
  bool get isComment => comment != null;

  /// Whether the bridge announced an intentional shutdown.
  bool get isClosing => (event ?? '').toLowerCase() == 'closing';

  /// Whether the frame carries a payload to decode.
  bool get hasData => data != null && data!.isNotEmpty;

  @override
  String toString() =>
      'BxKafkaSseFrame(event: $event, id: $id, comment: $comment, '
      'bytes: ${data?.length ?? 0})';
}

/// A minimal, allocation-friendly `text/event-stream` parser.
///
/// Feed it one line at a time (already split on `\r\n`, `\n` or `\r`). It
/// returns the frames that became complete at that line, so a stream consumer
/// can forward them immediately. Oversized frames are dropped instead of
/// buffered without bound — a hostile or broken bridge cannot exhaust memory.
class BxKafkaSseParser {
  /// Maximum number of characters buffered for a single frame.
  static const int maxFrameBytes = 1 << 20; // 1 MiB

  final List<String> _data = <String>[];
  String? _event;
  String? _id;
  int? _retry;
  int _bytes = 0;

  /// Consumes [line] and returns every frame completed by it.
  List<BxKafkaSseFrame> addLine(String line) {
    final frames = <BxKafkaSseFrame>[];

    // A blank line dispatches the accumulated frame.
    if (line.isEmpty) {
      final frame = _dispatch();
      if (frame != null) frames.add(frame);
      return frames;
    }

    // Comment line: a heartbeat or a keep-alive. Never dispatched as data.
    if (line.startsWith(':')) {
      frames.add(BxKafkaSseFrame(comment: line.substring(1).trim()));
      return frames;
    }

    _bytes += line.length;
    if (_bytes > maxFrameBytes) {
      // Drop the frame and resynchronise on the next blank line.
      _clear();
      return frames;
    }

    final colon = line.indexOf(':');
    final field = colon == -1 ? line : line.substring(0, colon);
    var value = colon == -1 ? '' : line.substring(colon + 1);
    if (value.startsWith(' ')) value = value.substring(1);

    switch (field) {
      case 'event':
        _event = value;
        break;
      case 'id':
        // Per the SSE spec an id containing NUL is ignored.
        if (!value.contains('\u0000')) _id = value;
        break;
      case 'retry':
        _retry = int.tryParse(value);
        break;
      case 'data':
        _data.add(value);
        break;
      default:
        // Unknown field: ignore, as the spec requires.
        break;
    }
    return frames;
  }

  /// Flushes a trailing frame that was not terminated by a blank line.
  ///
  /// Called when the underlying stream closes, so a final record is never lost.
  List<BxKafkaSseFrame> flush() {
    final frame = _dispatch();
    return frame == null ? const <BxKafkaSseFrame>[] : <BxKafkaSseFrame>[frame];
  }

  /// Drops all buffered state.
  void reset() => _clear();

  BxKafkaSseFrame? _dispatch() {
    if (_data.isEmpty && _event == null) {
      _clear();
      return null;
    }
    final frame = BxKafkaSseFrame(
      event: _event,
      id: _id,
      data: _data.join('\n'),
      retryMs: _retry,
    );
    final hadData = _data.isNotEmpty;
    _clear();
    // A frame with no data (e.g. only an `event:` line) is useless to callers.
    return hadData ? frame : null;
  }

  void _clear() {
    _data.clear();
    _event = null;
    _id = null;
    _bytes = 0;
    // `_retry` is connection-scoped in the spec, so it survives dispatch.
  }
}
