// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_recommended_for_customer_usecase.dart
// Architecture: Domain Layer - Bx Get Recommended For Customer UseCase
// Purpose: Defines the get recommended for customer use case

import 'package:tayara/domain/model/request/bx_get_recommended_for_customer_request.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/repositories/bx_get_recommended_for_customer_repositories.dart';

/// Use case that fetches the recommended packages for the customer with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetRecommendedForCustomerResponse] indicating success or failure.
class BxGetRecommendedForCustomerUsecase {
  final BxGetRecommendedForCustomerRepositories repositories;

  /// Creates a [BxGetRecommendedForCustomerUsecase] with the necessary [repositories].
  BxGetRecommendedForCustomerUsecase(this.repositories);

  /// Fetches the recommended packages for the customer with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetRecommendedForCustomerResponse> execute(
    BxGetRecommendedForCustomerRequest request,
  ) {
    return repositories.fetchRecommendedForCustomer(request);
  }
}
