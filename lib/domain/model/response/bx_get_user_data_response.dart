// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_get_user_data_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the current user's profile response (profile + trip/favorite counters)

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_user_data_response.g.dart';

@JsonSerializable()
class BxGetUserDataResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetUserData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetUserDataResponse({required this.code, this.data, required this.msg});

  factory BxGetUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetUserDataResponseToJson(this);
}

@JsonSerializable()
class BxGetUserData {
  @JsonKey(name: 'user')
  final BxGetUserDataUser? user;

  @JsonKey(name: 'pastTrips')
  final int? pastTrips;

  @JsonKey(name: 'upcoming')
  final int? upcoming;

  @JsonKey(name: 'favorites')
  final int? favorites;

  BxGetUserData({this.user, this.pastTrips, this.upcoming, this.favorites});

  factory BxGetUserData.fromJson(Map<String, dynamic> json) =>
      _$BxGetUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetUserDataToJson(this);
}

@JsonSerializable()
class BxGetUserDataUser {
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

  BxGetUserDataUser({
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

  factory BxGetUserDataUser.fromJson(Map<String, dynamic> json) =>
      _$BxGetUserDataUserFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetUserDataUserToJson(this);
}
