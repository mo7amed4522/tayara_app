// File: lib/domain/model/response/bx_login_user_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the user login response

import 'package:json_annotation/json_annotation.dart';

part 'bx_login_user_response.g.dart';

@JsonSerializable()
class BxLoginUserResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxLoginUserData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxLoginUserResponse({required this.code, this.data, required this.msg});

  factory BxLoginUserResponse.fromJson(Map<String, dynamic> json) =>
      _$BxLoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxLoginUserResponseToJson(this);
}

@JsonSerializable()
class BxLoginUserData {
  @JsonKey(name: 'user')
  final BxLoginUser? user;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'expiresAt')
  final int? expiresAt;

  BxLoginUserData({this.user, this.token, this.expiresAt});

  factory BxLoginUserData.fromJson(Map<String, dynamic> json) =>
      _$BxLoginUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxLoginUserDataToJson(this);
}

@JsonSerializable()
class BxLoginUser {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'nickName')
  final String? nickName;

  @JsonKey(name: 'headerImg')
  final String? headerImg;

  @JsonKey(name: 'phoneCountryCode')
  final String? phoneCountryCode;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'nationality')
  final String? nationality;

  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'kycStatus')
  final String? kycStatus;

  @JsonKey(name: 'totalSpend')
  final num? totalSpend;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'blockReason')
  final String? blockReason;

  @JsonKey(name: 'lastLoginAt')
  final String? lastLoginAt;

  @JsonKey(name: 'firebaseUid')
  final String? firebaseUid;

  @JsonKey(name: 'authProvider')
  final String? authProvider;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxLoginUser({
    this.id,
    this.fullName,
    this.userName,
    this.nickName,
    this.headerImg,
    this.phoneCountryCode,
    this.phone,
    this.email,
    this.nationality,
    this.dateOfBirth,
    this.kycStatus,
    this.totalSpend,
    this.status,
    this.blockReason,
    this.lastLoginAt,
    this.firebaseUid,
    this.authProvider,
    this.createdAt,
    this.updatedAt,
  });

  factory BxLoginUser.fromJson(Map<String, dynamic> json) =>
      _$BxLoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$BxLoginUserToJson(this);
}
