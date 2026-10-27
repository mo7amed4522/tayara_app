// File: lib/domain/model/request/bx_custom_search_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for the keyword search request (agents + packages)

import 'package:json_annotation/json_annotation.dart';

part 'bx_custom_search_request.g.dart';

@JsonSerializable()
class BxCustomSearchRequest {
  @JsonKey(name: 'keyword')
  final String keyword;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxCustomSearchRequest({
    required this.keyword,
    required this.page,
    required this.pageSize,
  });

  factory BxCustomSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCustomSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomSearchRequestToJson(this);
}
