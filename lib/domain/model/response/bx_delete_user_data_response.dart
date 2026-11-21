// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_delete_user_data_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the delete user data response

import 'package:json_annotation/json_annotation.dart';

part 'bx_delete_user_data_response.g.dart';

@JsonSerializable()
class BxDeleteUserDataResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final dynamic data;

  @JsonKey(name: 'msg')
  final String msg;

  BxDeleteUserDataResponse({required this.code, this.data, required this.msg});

  factory BxDeleteUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BxDeleteUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxDeleteUserDataResponseToJson(this);
}
