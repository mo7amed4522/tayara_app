// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_profile_response.dart
// Architecture: Domain Layer - Profile Response Models
// Purpose: Models for user profile API response

import 'package:json_annotation/json_annotation.dart';
import 'bx_firebase_login_response.dart';

part 'bx_profile_response.g.dart';

@JsonSerializable()
class BxProfileResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxFirebaseUser? data;

  BxProfileResponse({this.code, this.message, this.data});

  factory BxProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BxProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxProfileResponseToJson(this);
}
