// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxLoginUserRequest _$BxLoginUserRequestFromJson(Map<String, dynamic> json) =>
    BxLoginUserRequest(
      username: json['username'] as String?,
      password: json['password'] as String?,
      idToken: json['idToken'] as String?,
    );

Map<String, dynamic> _$BxLoginUserRequestToJson(BxLoginUserRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'idToken': instance.idToken,
    };
