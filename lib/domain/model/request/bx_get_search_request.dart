// File: lib/domain/model/request/bx_get_search_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for searching with keyword and pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_search_request.g.dart';

@JsonSerializable()
class BxGetSearchRequest {
  @JsonKey(name: 'keyword')
  final String keyword;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetSearchRequest({
    required this.keyword,
    required this.page,
    required this.pageSize,
  });

  factory BxGetSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetSearchRequestToJson(this);
}
