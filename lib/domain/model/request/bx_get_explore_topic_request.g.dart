// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_explore_topic_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetExploreTopicRequest _$BxGetExploreTopicRequestFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTopicRequest(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetExploreTopicRequestToJson(
  BxGetExploreTopicRequest instance,
) => <String, dynamic>{'page': instance.page, 'pageSize': instance.pageSize};
