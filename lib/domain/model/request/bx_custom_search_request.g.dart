// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_custom_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCustomSearchRequest _$BxCustomSearchRequestFromJson(
  Map<String, dynamic> json,
) => BxCustomSearchRequest(
  keyword: json['keyword'] as String,
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxCustomSearchRequestToJson(
  BxCustomSearchRequest instance,
) => <String, dynamic>{
  'keyword': instance.keyword,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
