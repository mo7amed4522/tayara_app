// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxProfileResponse _$BxProfileResponseFromJson(Map<String, dynamic> json) =>
    BxProfileResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : BxFirebaseUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BxProfileResponseToJson(BxProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'data': instance.data,
    };
