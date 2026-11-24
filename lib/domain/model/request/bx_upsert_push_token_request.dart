// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/request/bx_upsert_push_token_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for registering or updating a device push token

import 'package:json_annotation/json_annotation.dart';

part 'bx_upsert_push_token_request.g.dart';

@JsonSerializable()
class BxUpsertPushTokenRequest {
  @JsonKey(name: 'device_id')
  final String deviceId;

  @JsonKey(name: 'platform')
  final String platform;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'app_version')
  final String appVersion;

  /// Auth token used only for the `X-token` header — never serialized.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? authToken;
  BxUpsertPushTokenRequest({
    required this.deviceId,
    required this.platform,
    required this.token,
    required this.appVersion,
    this.authToken,
  });

  factory BxUpsertPushTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$BxUpsertPushTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxUpsertPushTokenRequestToJson(this);
}
