// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_home_response.dart
// Architecture: Domain Layer - Home Response Models
// Purpose: Models for home screen API responses (ads, destinations, explore trips, deals, agents, search)

import 'package:json_annotation/json_annotation.dart';

part 'bx_home_response.g.dart';

// ── Search ──────────────────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerSearchResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxCustomerSearchData? data;

  BxCustomerSearchResponse({this.code, this.message, this.data});

  factory BxCustomerSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerSearchResponseToJson(this);
}

@JsonSerializable()
class BxCustomerSearchData {
  @JsonKey(name: 'keyword')
  final String? keyword;

  @JsonKey(name: 'agents')
  final List<BxCustomerAgentResult>? agents;

  @JsonKey(name: 'packages')
  final List<BxCustomerPackageResult>? packages;

  @JsonKey(name: 'topExplore')
  final List<BxCustomerExploreResult>? topExplore;

  BxCustomerSearchData({
    this.keyword,
    this.agents,
    this.packages,
    this.topExplore,
  });

  // Empty constructor for handling missing/invalid data
  BxCustomerSearchData.empty()
      : keyword = null,
        agents = null,
        packages = null,
        topExplore = null;

  factory BxCustomerSearchData.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerSearchDataToJson(this);
}

@JsonSerializable()
class BxCustomerAgentResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'headerImg')
  final String? headerImg;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxCustomerAgentResult({
    this.id,
    this.companyName,
    this.headerImg,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxCustomerAgentResult.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentResultToJson(this);
}

@JsonSerializable()
class BxCustomerPackageResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxCustomerPackageResult({
    this.id,
    this.packageCode,
    this.agentId,
    this.companyName,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxCustomerPackageResult.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerPackageResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerPackageResultToJson(this);
}

@JsonSerializable()
class BxCustomerExploreResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxCustomerExploreResult({
    this.id,
    this.packageCode,
    this.agentId,
    this.companyName,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.description,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxCustomerExploreResult.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerExploreResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerExploreResultToJson(this);
}

// ── Destinations ────────────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerDestinationCard {
  @JsonKey(name: 'countryId')
  final int? countryId;

  @JsonKey(name: 'countryName')
  final String? countryName;

  @JsonKey(name: 'countryCode')
  final String? countryCode;

  @JsonKey(name: 'flagURL')
  final String? flagURL;

  @JsonKey(name: 'packageCount')
  final int? packageCount;

  @JsonKey(name: 'minDisplayPrice')
  final int? minDisplayPrice;

  BxCustomerDestinationCard({
    this.countryId,
    this.countryName,
    this.countryCode,
    this.flagURL,
    this.packageCount,
    this.minDisplayPrice,
  });

  factory BxCustomerDestinationCard.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerDestinationCardFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerDestinationCardToJson(this);
}

// ── Explore Trips ───────────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerExploreTripCard {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxCustomerExploreTripCard({
    this.id,
    this.packageCode,
    this.agentId,
    this.companyName,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxCustomerExploreTripCard.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerExploreTripCardFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerExploreTripCardToJson(this);
}

// ── Deals ───────────────────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerDealResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'agentName')
  final String? agentName;

  @JsonKey(name: 'agentLogo')
  final String? agentLogo;

  @JsonKey(name: 'viewCount')
  final int? viewCount;

  BxCustomerDealResult({
    this.id,
    this.packageCode,
    this.agentId,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.rating,
    this.reviewCount,
    this.status,
    this.agentName,
    this.agentLogo,
    this.viewCount,
  });

  factory BxCustomerDealResult.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerDealResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerDealResultToJson(this);
}

// ── Top Rated Agents ────────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerAgentCard {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'headerImg')
  final String? headerImg;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'phoneCountryCode')
  final String? phoneCountryCode;

  @JsonKey(name: 'businessEmail')
  final String? businessEmail;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'companyAddress')
  final String? companyAddress;

  @JsonKey(name: 'licenseNumber')
  final String? licenseNumber;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'averageRating')
  final double? averageRating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'trustedTravelersCount')
  final int? trustedTravelersCount;

  @JsonKey(name: 'shortDescription')
  final String? shortDescription;

  @JsonKey(name: 'longDescription')
  final String? longDescription;

  BxCustomerAgentCard({
    this.id,
    this.companyName,
    this.headerImg,
    this.phone,
    this.phoneCountryCode,
    this.businessEmail,
    this.country,
    this.companyAddress,
    this.licenseNumber,
    this.status,
    this.averageRating,
    this.reviewCount,
    this.trustedTravelersCount,
    this.shortDescription,
    this.longDescription,
  });

  factory BxCustomerAgentCard.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentCardFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentCardToJson(this);
}

// ── Ad Banners ──────────────────────────────────────────────────────────────

@JsonSerializable()
class BxAdBannerResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'adCode')
  final String? adCode;

  @JsonKey(name: 'bannerImageURL')
  final String? bannerImageURL;

  @JsonKey(name: 'overlayTitle')
  final String? overlayTitle;

  @JsonKey(name: 'overlaySubtitle')
  final String? overlaySubtitle;

  @JsonKey(name: 'ctaLabel')
  final String? ctaLabel;

  @JsonKey(name: 'redirectType')
  final String? redirectType;

  @JsonKey(name: 'targetCountryId')
  final int? targetCountryId;

  @JsonKey(name: 'targetAgentId')
  final int? targetAgentId;

  @JsonKey(name: 'targetPackageId')
  final int? targetPackageId;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxAdBannerResult({
    this.id,
    this.adCode,
    this.bannerImageURL,
    this.overlayTitle,
    this.overlaySubtitle,
    this.ctaLabel,
    this.redirectType,
    this.targetCountryId,
    this.targetAgentId,
    this.targetPackageId,
    this.createdAt,
  });

  factory BxAdBannerResult.fromJson(Map<String, dynamic> json) =>
      _$BxAdBannerResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxAdBannerResultToJson(this);
}

// ── Recommended For You ─────────────────────────────────────────────────────

@JsonSerializable()
class BxCustomerRecommendedResult {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'agentName')
  final String? agentName;

  @JsonKey(name: 'agentLogo')
  final String? agentLogo;

  @JsonKey(name: 'viewCount')
  final int? viewCount;

  @JsonKey(name: 'wishlisted')
  final bool? wishlisted;

  BxCustomerRecommendedResult({
    this.id,
    this.packageCode,
    this.agentId,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.rating,
    this.reviewCount,
    this.agentName,
    this.agentLogo,
    this.viewCount,
    this.wishlisted,
  });

  factory BxCustomerRecommendedResult.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerRecommendedResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerRecommendedResultToJson(this);
}

// ── Page Result wrapper ─────────────────────────────────────────────────────

@JsonSerializable()
class BxPageResult {
  @JsonKey(name: 'list')
  final List<dynamic>? list;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'totalPage')
  final int? totalPage;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'pageSize')
  final int? pageSize;

  BxPageResult({
    this.list,
    this.total,
    this.totalPage,
    this.page,
    this.pageSize,
  });

  factory BxPageResult.fromJson(Map<String, dynamic> json) =>
      _$BxPageResultFromJson(json);

  Map<String, dynamic> toJson() => _$BxPageResultToJson(this);
}
