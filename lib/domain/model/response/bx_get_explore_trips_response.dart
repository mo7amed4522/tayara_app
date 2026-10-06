// File: lib/domain/model/response/bx_get_explore_trips_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the explore trips list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_explore_trips_response.g.dart';

@JsonSerializable()
class BxGetExploreTripsResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetExploreTripsData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetExploreTripsResponse({required this.code, this.data, required this.msg});

  factory BxGetExploreTripsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTripsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTripsResponseToJson(this);
}

@JsonSerializable()
class BxGetExploreTripsData {
  @JsonKey(name: 'list')
  final List<BxGetExploreTrip> list;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetExploreTripsData({
    required this.list,
    required this.total,
    required this.totalPage,
    required this.page,
    required this.pageSize,
  });

  factory BxGetExploreTripsData.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTripsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTripsDataToJson(this);
}

@JsonSerializable()
class BxGetExploreTrip {
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

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'status')
  final String? status;

  BxGetExploreTrip({
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
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BxGetExploreTrip.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTripFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTripToJson(this);
}
