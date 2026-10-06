// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetSearchRequest _$BxGetSearchRequestFromJson(Map<String, dynamic> json) =>
    BxGetSearchRequest(
      keyword: json['keyword'] as String,
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );

Map<String, dynamic> _$BxGetSearchRequestToJson(BxGetSearchRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
