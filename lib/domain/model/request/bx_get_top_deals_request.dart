// File: lib/domain/model/request/bx_get_top_deals_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching top deals with pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_top_deals_request.g.dart';

@JsonSerializable()
class BxGetTopDealsRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetTopDealsRequest({required this.page, required this.pageSize});

  factory BxGetTopDealsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopDealsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopDealsRequestToJson(this);
}
