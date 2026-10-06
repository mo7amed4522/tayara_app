// File: lib/domain/model/response/bx_get_destinations_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the destinations list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_destinations_response.g.dart';

@JsonSerializable()
class BxGetDestinationsResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetDestinationsData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetDestinationsResponse({required this.code, this.data, required this.msg});

  factory BxGetDestinationsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationsResponseToJson(this);
}

@JsonSerializable()
class BxGetDestinationsData {
  @JsonKey(name: 'list')
  final List<BxGetDestination> list;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetDestinationsData({
    required this.list,
    required this.total,
    required this.totalPage,
    required this.page,
    required this.pageSize,
  });

  factory BxGetDestinationsData.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationsDataToJson(this);
}

@JsonSerializable()
class BxGetDestination {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'imageURL')
  final String? imageUrl;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'countryId')
  final int? countryId;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxGetDestination({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.description,
    this.countryId,
    this.isActive,
    this.createdAt,
  });

  factory BxGetDestination.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationToJson(this);
}
