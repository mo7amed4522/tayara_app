// File: lib/domain/model/response/bx_firebase_login_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for Firebase login response

import 'package:json_annotation/json_annotation.dart';

part 'bx_firebase_login_response.g.dart';

@JsonSerializable()
class BxFirebaseLoginResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxFirebaseLoginData? data;

  BxFirebaseLoginResponse({this.code, this.message, this.data});

  factory BxFirebaseLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$BxFirebaseLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxFirebaseLoginResponseToJson(this);
}

@JsonSerializable()
class BxFirebaseLoginData {
  @JsonKey(name: 'user')
  final BxFirebaseUser? user;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'expiresAt')
  final int? expiresAt;

  BxFirebaseLoginData({this.user, this.token, this.expiresAt});

  factory BxFirebaseLoginData.fromJson(Map<String, dynamic> json) =>
      _$BxFirebaseLoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxFirebaseLoginDataToJson(this);
}

@JsonSerializable()
class BxFirebaseUser {
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
  final int? totalSpend;

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

  BxFirebaseUser({
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

  factory BxFirebaseUser.fromJson(Map<String, dynamic> json) =>
      _$BxFirebaseUserFromJson(json);

  Map<String, dynamic> toJson() => _$BxFirebaseUserToJson(this);
}
