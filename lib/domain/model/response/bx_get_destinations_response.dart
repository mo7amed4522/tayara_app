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
  /// Backend sends this as `countryId` — treat it as the destination's ID.
  @JsonKey(name: 'countryId')
  final int? id;

  @JsonKey(name: 'countryName')
  final String? name;

  @JsonKey(name: 'countryCode')
  final String? code;

  /// Number of active packages in this destination.
  @JsonKey(name: 'packageCount')
  final int? packageCount;

  /// Cheapest active package's display price, in minor units (fils).
  @JsonKey(name: 'minDisplayPrice')
  final int? minDisplayPrice;

  BxGetDestination({
    this.id,
    this.name,
    this.code,
    this.packageCount,
    this.minDisplayPrice,
  });

  factory BxGetDestination.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationToJson(this);

  /// Convenience getter: formatted "From $X" string, or null if no price.
  String? get priceLabel {
    final p = minDisplayPrice;
    if (p == null || p <= 0) return null;
    return 'From \$${(p / 100).toStringAsFixed(0)}';
  }
}
