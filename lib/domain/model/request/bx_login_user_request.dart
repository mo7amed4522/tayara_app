// File: lib/domain/model/request/bx_login_user_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for user login with credentials

import 'package:json_annotation/json_annotation.dart';

part 'bx_login_user_request.g.dart';

@JsonSerializable()
class BxLoginUserRequest {
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'idToken')
  final String? idToken;
  BxLoginUserRequest({this.username, this.password, this.idToken});

  factory BxLoginUserRequest.fromJson(Map<String, dynamic> json) =>
      _$BxLoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxLoginUserRequestToJson(this);
}
