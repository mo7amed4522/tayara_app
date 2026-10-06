// File: lib/domain/model/request/bx_get_destinations_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching destinations with pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_destinations_request.g.dart';

@JsonSerializable()
class BxGetDestinationsRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetDestinationsRequest({required this.page, required this.pageSize});

  factory BxGetDestinationsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationsRequestToJson(this);
}
