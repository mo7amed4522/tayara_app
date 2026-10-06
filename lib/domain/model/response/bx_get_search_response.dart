// File: lib/domain/model/response/bx_get_search_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the search results response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_search_response.g.dart';

@JsonSerializable()
class BxGetSearchResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetSearchData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetSearchResponse({required this.code, this.data, required this.msg});

  factory BxGetSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetSearchResponseToJson(this);
}

@JsonSerializable()
class BxGetSearchData {
  @JsonKey(name: 'keyword')
  final String? keyword;

  @JsonKey(name: 'agents')
  final List<BxSearchAgent>? agents;

  @JsonKey(name: 'packages')
  final List<BxSearchPackage>? packages;

  @JsonKey(name: 'topExplore')
  final List<BxSearchPackage>? topExplore;

  BxGetSearchData({this.keyword, this.agents, this.packages, this.topExplore});

  factory BxGetSearchData.fromJson(Map<String, dynamic> json) =>
      _$BxGetSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetSearchDataToJson(this);
}

@JsonSerializable()
class BxSearchAgent {
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

  BxSearchAgent({
    this.id,
    this.companyName,
    this.headerImg,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxSearchAgent.fromJson(Map<String, dynamic> json) =>
      _$BxSearchAgentFromJson(json);

  Map<String, dynamic> toJson() => _$BxSearchAgentToJson(this);
}

@JsonSerializable()
class BxSearchPackage {
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
  final String? coverImageUrl;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final num? displayPrice;

  @JsonKey(name: 'discountPercent')
  final num? discountPercent;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxSearchPackage({
    this.id,
    this.packageCode,
    this.agentId,
    this.companyName,
    this.name,
    this.coverImageUrl,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.description,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxSearchPackage.fromJson(Map<String, dynamic> json) =>
      _$BxSearchPackageFromJson(json);

  Map<String, dynamic> toJson() => _$BxSearchPackageToJson(this);
}
