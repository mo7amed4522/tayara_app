// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_custom_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCustomSearchResponse _$BxCustomSearchResponseFromJson(
  Map<String, dynamic> json,
) => BxCustomSearchResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxCustomSearchData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxCustomSearchResponseToJson(
  BxCustomSearchResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxCustomSearchData _$BxCustomSearchDataFromJson(Map<String, dynamic> json) =>
    BxCustomSearchData(
      keyword: json['keyword'] as String,
      agents: (json['agents'] as List<dynamic>)
          .map((e) => BxCustomSearchAgent.fromJson(e as Map<String, dynamic>))
          .toList(),
      topExplore: (json['topExplore'] as List<dynamic>)
          .map((e) => BxCustomSearchPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      similarDestinations: (json['similarDestinations'] as List<dynamic>)
          .map((e) => BxCustomSearchPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BxCustomSearchDataToJson(BxCustomSearchData instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'agents': instance.agents,
      'topExplore': instance.topExplore,
      'similarDestinations': instance.similarDestinations,
    };

BxCustomSearchAgent _$BxCustomSearchAgentFromJson(Map<String, dynamic> json) =>
    BxCustomSearchAgent(
      id: (json['id'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      headerImg: json['headerImg'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BxCustomSearchAgentToJson(
  BxCustomSearchAgent instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'headerImg': instance.headerImg,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
};

BxCustomSearchPackage _$BxCustomSearchPackageFromJson(
  Map<String, dynamic> json,
) => BxCustomSearchPackage(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  name: json['name'] as String?,
  coverImageUrl: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BxCustomSearchPackageToJson(
  BxCustomSearchPackage instance,
) => <String, dynamic>{
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
