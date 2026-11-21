// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_update_user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxUpdateUserDataResponse _$BxUpdateUserDataResponseFromJson(
  Map<String, dynamic> json,
) => BxUpdateUserDataResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxUpdateUserData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxUpdateUserDataResponseToJson(
  BxUpdateUserDataResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxUpdateUserData _$BxUpdateUserDataFromJson(Map<String, dynamic> json) =>
    BxUpdateUserData(
      user: json['user'] == null
          ? null
          : BxGetUserDataUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BxUpdateUserDataToJson(BxUpdateUserData instance) =>
    <String, dynamic>{'user': instance.user};
