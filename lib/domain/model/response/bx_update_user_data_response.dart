// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_update_user_data_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the update user data response

import 'package:json_annotation/json_annotation.dart';
import 'package:tayara/domain/model/response/bx_get_user_data_response.dart';

part 'bx_update_user_data_response.g.dart';

@JsonSerializable()
class BxUpdateUserDataResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxUpdateUserData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxUpdateUserDataResponse({required this.code, this.data, required this.msg});

  factory BxUpdateUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BxUpdateUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxUpdateUserDataResponseToJson(this);
}

@JsonSerializable()
class BxUpdateUserData {
  @JsonKey(name: 'user')
  final BxGetUserDataUser? user;

  BxUpdateUserData({this.user});

  factory BxUpdateUserData.fromJson(Map<String, dynamic> json) =>
      _$BxUpdateUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxUpdateUserDataToJson(this);
}
