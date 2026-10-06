// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetSearchResponse _$BxGetSearchResponseFromJson(Map<String, dynamic> json) =>
    BxGetSearchResponse(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : BxGetSearchData.fromJson(json['data'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$BxGetSearchResponseToJson(
  BxGetSearchResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetSearchData _$BxGetSearchDataFromJson(Map<String, dynamic> json) =>
    BxGetSearchData(
      keyword: json['keyword'] as String?,
      agents: (json['agents'] as List<dynamic>?)
          ?.map((e) => BxSearchAgent.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => BxSearchPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      topExplore: (json['topExplore'] as List<dynamic>?)
          ?.map((e) => BxSearchPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BxGetSearchDataToJson(BxGetSearchData instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'agents': instance.agents,
      'packages': instance.packages,
      'topExplore': instance.topExplore,
    };

BxSearchAgent _$BxSearchAgentFromJson(Map<String, dynamic> json) =>
    BxSearchAgent(
      id: (json['id'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      headerImg: json['headerImg'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BxSearchAgentToJson(BxSearchAgent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'headerImg': instance.headerImg,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'status': instance.status,
    };

BxSearchPackage _$BxSearchPackageFromJson(Map<String, dynamic> json) =>
    BxSearchPackage(
      id: (json['id'] as num?)?.toInt(),
      packageCode: json['packageCode'] as String?,
      agentId: (json['agentId'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      name: json['name'] as String?,
      coverImageUrl: json['coverImageURL'] as String?,
      category: json['category'] as String?,
      daysDuration: (json['daysDuration'] as num?)?.toInt(),
      displayPrice: json['displayPrice'] as num?,
      discountPercent: json['discountPercent'] as num?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BxSearchPackageToJson(BxSearchPackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageCode': instance.packageCode,
      'agentId': instance.agentId,
      'companyName': instance.companyName,
      'name': instance.name,
      'coverImageURL': instance.coverImageUrl,
      'category': instance.category,
      'daysDuration': instance.daysDuration,
      'displayPrice': instance.displayPrice,
      'discountPercent': instance.discountPercent,
      'description': instance.description,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'status': instance.status,
    };
