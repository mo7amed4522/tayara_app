// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_delete_user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxDeleteUserDataResponse _$BxDeleteUserDataResponseFromJson(
  Map<String, dynamic> json,
) => BxDeleteUserDataResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'],
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxDeleteUserDataResponseToJson(
  BxDeleteUserDataResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};
