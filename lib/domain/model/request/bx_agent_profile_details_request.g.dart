// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_agent_profile_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxAgentProfileDetailsRequest _$BxAgentProfileDetailsRequestFromJson(
  Map<String, dynamic> json,
) => BxAgentProfileDetailsRequest(
  agentId: (json['agentId'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxAgentProfileDetailsRequestToJson(
  BxAgentProfileDetailsRequest instance,
) => <String, dynamic>{
  'agentId': instance.agentId,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
