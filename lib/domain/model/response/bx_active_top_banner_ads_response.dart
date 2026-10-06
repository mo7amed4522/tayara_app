// File: lib/domain/model/response/bx_active_top_banner_ads_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the active top banner ads list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_active_top_banner_ads_response.g.dart';

@JsonSerializable()
class BxActiveTopBannerAdsResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxActiveTopBannerAdsData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxActiveTopBannerAdsResponse({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BxActiveTopBannerAdsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxActiveTopBannerAdsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxActiveTopBannerAdsResponseToJson(this);
}

@JsonSerializable()
class BxActiveTopBannerAdsData {
  @JsonKey(name: 'list')
  final List<BxActiveTopBannerAd> list;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxActiveTopBannerAdsData({
    required this.list,
    required this.total,
    required this.totalPage,
    required this.page,
    required this.pageSize,
  });

  factory BxActiveTopBannerAdsData.fromJson(Map<String, dynamic> json) =>
      _$BxActiveTopBannerAdsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxActiveTopBannerAdsDataToJson(this);
}

@JsonSerializable()
class BxActiveTopBannerAd {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'adCode')
  final String? adCode;

  @JsonKey(name: 'bannerImageURL')
  final String? bannerImageUrl;

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

  BxActiveTopBannerAd({
    this.id,
    this.adCode,
    this.bannerImageUrl,
    this.overlayTitle,
    this.overlaySubtitle,
    this.ctaLabel,
    this.redirectType,
    this.targetCountryId,
    this.targetAgentId,
    this.targetPackageId,
    this.createdAt,
  });

  factory BxActiveTopBannerAd.fromJson(Map<String, dynamic> json) =>
      _$BxActiveTopBannerAdFromJson(json);

  Map<String, dynamic> toJson() => _$BxActiveTopBannerAdToJson(this);
}
