// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_explore_topic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetExploreTopicResponse _$BxGetExploreTopicResponseFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTopicResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetExploreTopicData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetExploreTopicResponseToJson(
  BxGetExploreTopicResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetExploreTopicData _$BxGetExploreTopicDataFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTopicData(
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  list: (json['data'] as List<dynamic>)
      .map((e) => BxExploreTopic.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BxGetExploreTopicDataToJson(
  BxGetExploreTopicData instance,
) => <String, dynamic>{
  'total': instance.total,
  'page': instance.page,
  'pageSize': instance.pageSize,
  'totalPage': instance.totalPage,
  'data': instance.list,
};

BxExploreTopic _$BxExploreTopicFromJson(Map<String, dynamic> json) =>
    BxExploreTopic(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      nameAr: json['nameAr'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      iconUrl: json['iconUrl'] as String?,
      packageCount: (json['packageCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxExploreTopicToJson(BxExploreTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'nameAr': instance.nameAr,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'iconUrl': instance.iconUrl,
      'packageCount': instance.packageCount,
    };
