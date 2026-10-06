// File: lib/domain/model/request/bx_get_recommended_for_customer_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching recommended packages for a customer with a limit

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_recommended_for_customer_request.g.dart';

@JsonSerializable()
class BxGetRecommendedForCustomerRequest {
  @JsonKey(name: 'limit')
  final int limit;

  BxGetRecommendedForCustomerRequest({required this.limit});

  factory BxGetRecommendedForCustomerRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$BxGetRecommendedForCustomerRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BxGetRecommendedForCustomerRequestToJson(this);
}
