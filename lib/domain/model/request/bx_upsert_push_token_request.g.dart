// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_upsert_push_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxUpsertPushTokenRequest _$BxUpsertPushTokenRequestFromJson(
  Map<String, dynamic> json,
) => BxUpsertPushTokenRequest(
  deviceId: json['device_id'] as String,
  platform: json['platform'] as String,
  token: json['token'] as String,
  appVersion: json['app_version'] as String,
);

Map<String, dynamic> _$BxUpsertPushTokenRequestToJson(
  BxUpsertPushTokenRequest instance,
) => <String, dynamic>{
  'device_id': instance.deviceId,
  'platform': instance.platform,
  'token': instance.token,
  'app_version': instance.appVersion,
};
