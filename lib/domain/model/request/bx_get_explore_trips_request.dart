// File: lib/domain/model/request/bx_get_explore_trips_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching explore trips with pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_explore_trips_request.g.dart';

@JsonSerializable()
class BxGetExploreTripsRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'category')
  final String? category;

  BxGetExploreTripsRequest({
    required this.page,
    required this.pageSize,
    this.category,
  });

  factory BxGetExploreTripsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTripsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTripsRequestToJson(this);
}
