// File: lib/domain/model/response/bx_custom_search_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the keyword search result (agents + explore packages + similar destinations)

import 'package:json_annotation/json_annotation.dart';

part 'bx_custom_search_response.g.dart';

@JsonSerializable()
class BxCustomSearchResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxCustomSearchData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxCustomSearchResponse({required this.code, this.data, required this.msg});

  factory BxCustomSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$BxCustomSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomSearchResponseToJson(this);
}

@JsonSerializable()
class BxCustomSearchData {
  @JsonKey(name: 'keyword')
  final String keyword;

  @JsonKey(name: 'agents')
  final List<BxCustomSearchAgent> agents;

  @JsonKey(name: 'topExplore')
  final List<BxCustomSearchPackage> topExplore;

  @JsonKey(name: 'similarDestinations')
  final List<BxCustomSearchPackage> similarDestinations;

  BxCustomSearchData({
    required this.keyword,
    required this.agents,
    required this.topExplore,
    required this.similarDestinations,
  });

  factory BxCustomSearchData.fromJson(Map<String, dynamic> json) =>
      _$BxCustomSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomSearchDataToJson(this);
}

@JsonSerializable()
class BxCustomSearchAgent {
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

  BxCustomSearchAgent({
    this.id,
    this.companyName,
    this.headerImg,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxCustomSearchAgent.fromJson(Map<String, dynamic> json) =>
      _$BxCustomSearchAgentFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomSearchAgentToJson(this);
}

@JsonSerializable()
class BxCustomSearchPackage {
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

  BxCustomSearchPackage({
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

  factory BxCustomSearchPackage.fromJson(Map<String, dynamic> json) =>
      _$BxCustomSearchPackageFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomSearchPackageToJson(this);
}
