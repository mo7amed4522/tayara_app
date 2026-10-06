// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_recommended_for_customer_repositories.dart
// Architecture: Domain Layer - Bx Get Recommended For Customer Repository
// Purpose: Define the get recommended for customer repository for the application

import 'package:tayara/domain/model/request/bx_get_recommended_for_customer_request.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';

///
/// Implementations call the remote get recommended for customer endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetRecommendedForCustomerRepositories {
  /// Fetches the recommended packages for the customer with the provided request.
  ///
  /// Returns a [BxGetRecommendedForCustomerResponse] indicating success or failure.
  Future<BxGetRecommendedForCustomerResponse> fetchRecommendedForCustomer(
    BxGetRecommendedForCustomerRequest request,
  );
}
