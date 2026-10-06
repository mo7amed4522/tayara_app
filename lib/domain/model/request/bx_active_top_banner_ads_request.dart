// File: lib/domain/model/request/bx_active_top_banner_ads_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching active top banner ads with pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_active_top_banner_ads_request.g.dart';

@JsonSerializable()
class BxActiveTopBannerAdsRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxActiveTopBannerAdsRequest({required this.page, required this.pageSize});

  factory BxActiveTopBannerAdsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxActiveTopBannerAdsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxActiveTopBannerAdsRequestToJson(this);
}
