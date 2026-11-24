// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_upsert_push_token_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the upsert push token response

import 'package:json_annotation/json_annotation.dart';

part 'bx_upsert_push_token_response.g.dart';

@JsonSerializable()
class BxUpsertPushTokenResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxUpsertPushTokenData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxUpsertPushTokenResponse({required this.code, this.data, required this.msg});

  factory BxUpsertPushTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$BxUpsertPushTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxUpsertPushTokenResponseToJson(this);
}

@JsonSerializable()
class BxUpsertPushTokenData {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'deviceId')
  final String? deviceId;

  @JsonKey(name: 'platform')
  final String? platform;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'lastSeenAt')
  final String? lastSeenAt;

  BxUpsertPushTokenData({
    this.id,
    this.deviceId,
    this.platform,
    this.isActive,
    this.lastSeenAt,
  });

  factory BxUpsertPushTokenData.fromJson(Map<String, dynamic> json) =>
      _$BxUpsertPushTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxUpsertPushTokenDataToJson(this);
}
