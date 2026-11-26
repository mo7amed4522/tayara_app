// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_upsert_push_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxUpsertPushTokenResponse _$BxUpsertPushTokenResponseFromJson(
  Map<String, dynamic> json,
) => BxUpsertPushTokenResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxUpsertPushTokenData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxUpsertPushTokenResponseToJson(
  BxUpsertPushTokenResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxUpsertPushTokenData _$BxUpsertPushTokenDataFromJson(
  Map<String, dynamic> json,
) => BxUpsertPushTokenData(
  id: (json['id'] as num?)?.toInt(),
  deviceId: json['deviceId'] as String?,
  platform: json['platform'] as String?,
  isActive: json['isActive'] as bool?,
  lastSeenAt: json['lastSeenAt'] as String?,
);

Map<String, dynamic> _$BxUpsertPushTokenDataToJson(
  BxUpsertPushTokenData instance,
) => <String, dynamic>{
  'id': instance.id,
  'deviceId': instance.deviceId,
  'platform': instance.platform,
  'isActive': instance.isActive,
  'lastSeenAt': instance.lastSeenAt,
};
