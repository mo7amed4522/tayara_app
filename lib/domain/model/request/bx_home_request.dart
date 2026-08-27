// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/request/bx_home_request.dart
// Architecture: Domain Layer - Home Request Models
// Purpose: Models for home screen API requests

import 'package:json_annotation/json_annotation.dart';

part 'bx_home_request.g.dart';

@JsonSerializable()
class BxCustomerSearchRequest {
  @JsonKey(name: 'keyword')
  final String keyword;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxCustomerSearchRequest({
    required this.keyword,
    this.page = 1,
    this.pageSize = 10,
  });

  factory BxCustomerSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerSearchRequestToJson(this);
}

@JsonSerializable()
class BxCustomerExploreRequest {
  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxCustomerExploreRequest({this.category, this.page = 1, this.pageSize = 12});

  factory BxCustomerExploreRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerExploreRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerExploreRequestToJson(this);
}

@JsonSerializable()
class BxCustomerDealsRequest {
  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxCustomerDealsRequest({this.category, this.page = 1, this.pageSize = 12});

  factory BxCustomerDealsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerDealsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerDealsRequestToJson(this);
}

@JsonSerializable()
class BxCustomerAgentDetailRequest {
  @JsonKey(name: 'agentId')
  final int agentId;

  @JsonKey(name: 'destinationCountryId')
  final int? destinationCountryId;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxCustomerAgentDetailRequest({
    required this.agentId,
    this.destinationCountryId,
    this.page = 1,
    this.pageSize = 12,
  });

  factory BxCustomerAgentDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentDetailRequestToJson(this);
}
