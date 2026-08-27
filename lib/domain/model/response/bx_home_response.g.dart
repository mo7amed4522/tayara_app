// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCustomerSearchResponse _$BxCustomerSearchResponseFromJson(
  Map<String, dynamic> json,
) => BxCustomerSearchResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxCustomerSearchData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxCustomerSearchResponseToJson(
  BxCustomerSearchResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxCustomerSearchData _$BxCustomerSearchDataFromJson(
  Map<String, dynamic> json,
) => BxCustomerSearchData(
  keyword: json['keyword'] as String?,
  agents: (json['agents'] as List<dynamic>?)
      ?.map((e) => BxCustomerAgentResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  packages: (json['packages'] as List<dynamic>?)
      ?.map((e) => BxCustomerPackageResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  topExplore: (json['topExplore'] as List<dynamic>?)
      ?.map((e) => BxCustomerExploreResult.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BxCustomerSearchDataToJson(
  BxCustomerSearchData instance,
) => <String, dynamic>{
  'keyword': instance.keyword,
  'agents': instance.agents,
  'packages': instance.packages,
  'topExplore': instance.topExplore,
};

BxCustomerAgentResult _$BxCustomerAgentResultFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentResult(
  id: (json['id'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  headerImg: json['headerImg'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BxCustomerAgentResultToJson(
  BxCustomerAgentResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'headerImg': instance.headerImg,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
};

BxCustomerPackageResult _$BxCustomerPackageResultFromJson(
  Map<String, dynamic> json,
) => BxCustomerPackageResult(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BxCustomerPackageResultToJson(
  BxCustomerPackageResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'companyName': instance.companyName,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
};

BxCustomerExploreResult _$BxCustomerExploreResultFromJson(
  Map<String, dynamic> json,
) => BxCustomerExploreResult(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BxCustomerExploreResultToJson(
  BxCustomerExploreResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'companyName': instance.companyName,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'description': instance.description,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
};

BxCustomerDestinationCard _$BxCustomerDestinationCardFromJson(
  Map<String, dynamic> json,
) => BxCustomerDestinationCard(
  countryId: (json['countryId'] as num?)?.toInt(),
  countryName: json['countryName'] as String?,
  countryCode: json['countryCode'] as String?,
  flagURL: json['flagURL'] as String?,
  packageCount: (json['packageCount'] as num?)?.toInt(),
  minDisplayPrice: (json['minDisplayPrice'] as num?)?.toInt(),
);

Map<String, dynamic> _$BxCustomerDestinationCardToJson(
  BxCustomerDestinationCard instance,
) => <String, dynamic>{
  'countryId': instance.countryId,
  'countryName': instance.countryName,
  'countryCode': instance.countryCode,
  'flagURL': instance.flagURL,
  'packageCount': instance.packageCount,
  'minDisplayPrice': instance.minDisplayPrice,
};

BxCustomerExploreTripCard _$BxCustomerExploreTripCardFromJson(
  Map<String, dynamic> json,
) => BxCustomerExploreTripCard(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$BxCustomerExploreTripCardToJson(
  BxCustomerExploreTripCard instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'companyName': instance.companyName,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
};

BxCustomerDealResult _$BxCustomerDealResultFromJson(
  Map<String, dynamic> json,
) => BxCustomerDealResult(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  status: json['status'] as String?,
  agentName: json['agentName'] as String?,
  agentLogo: json['agentLogo'] as String?,
  viewCount: (json['viewCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$BxCustomerDealResultToJson(
  BxCustomerDealResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'status': instance.status,
  'agentName': instance.agentName,
  'agentLogo': instance.agentLogo,
  'viewCount': instance.viewCount,
};

BxCustomerAgentCard _$BxCustomerAgentCardFromJson(Map<String, dynamic> json) =>
    BxCustomerAgentCard(
      id: (json['id'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      headerImg: json['headerImg'] as String?,
      phone: json['phone'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      businessEmail: json['businessEmail'] as String?,
      country: json['country'] as String?,
      companyAddress: json['companyAddress'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      status: json['status'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      trustedTravelersCount: (json['trustedTravelersCount'] as num?)?.toInt(),
      shortDescription: json['shortDescription'] as String?,
      longDescription: json['longDescription'] as String?,
    );

Map<String, dynamic> _$BxCustomerAgentCardToJson(
  BxCustomerAgentCard instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'headerImg': instance.headerImg,
  'phone': instance.phone,
  'phoneCountryCode': instance.phoneCountryCode,
  'businessEmail': instance.businessEmail,
  'country': instance.country,
  'companyAddress': instance.companyAddress,
  'licenseNumber': instance.licenseNumber,
  'status': instance.status,
  'averageRating': instance.averageRating,
  'reviewCount': instance.reviewCount,
  'trustedTravelersCount': instance.trustedTravelersCount,
  'shortDescription': instance.shortDescription,
  'longDescription': instance.longDescription,
};

BxAdBannerResult _$BxAdBannerResultFromJson(Map<String, dynamic> json) =>
    BxAdBannerResult(
      id: (json['id'] as num?)?.toInt(),
      adCode: json['adCode'] as String?,
      bannerImageURL: json['bannerImageURL'] as String?,
      overlayTitle: json['overlayTitle'] as String?,
      overlaySubtitle: json['overlaySubtitle'] as String?,
      ctaLabel: json['ctaLabel'] as String?,
      redirectType: json['redirectType'] as String?,
      targetCountryId: (json['targetCountryId'] as num?)?.toInt(),
      targetAgentId: (json['targetAgentId'] as num?)?.toInt(),
      targetPackageId: (json['targetPackageId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BxAdBannerResultToJson(BxAdBannerResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'adCode': instance.adCode,
      'bannerImageURL': instance.bannerImageURL,
      'overlayTitle': instance.overlayTitle,
      'overlaySubtitle': instance.overlaySubtitle,
      'ctaLabel': instance.ctaLabel,
      'redirectType': instance.redirectType,
      'targetCountryId': instance.targetCountryId,
      'targetAgentId': instance.targetAgentId,
      'targetPackageId': instance.targetPackageId,
      'createdAt': instance.createdAt,
    };

BxCustomerRecommendedResult _$BxCustomerRecommendedResultFromJson(
  Map<String, dynamic> json,
) => BxCustomerRecommendedResult(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  agentName: json['agentName'] as String?,
  agentLogo: json['agentLogo'] as String?,
  viewCount: (json['viewCount'] as num?)?.toInt(),
  wishlisted: json['wishlisted'] as bool?,
);

Map<String, dynamic> _$BxCustomerRecommendedResultToJson(
  BxCustomerRecommendedResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'agentName': instance.agentName,
  'agentLogo': instance.agentLogo,
  'viewCount': instance.viewCount,
  'wishlisted': instance.wishlisted,
};

BxPageResult _$BxPageResultFromJson(Map<String, dynamic> json) => BxPageResult(
  list: json['list'] as List<dynamic>?,
  total: (json['total'] as num?)?.toInt(),
  totalPage: (json['totalPage'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$BxPageResultToJson(BxPageResult instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
