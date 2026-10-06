// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_top_deals_repositories.dart
// Architecture: Domain Layer - Bx Get Top Deals Repository
// Purpose: Define the get top deals repository for the application

import 'package:tayara/domain/model/request/bx_get_top_deals_request.dart';
import 'package:tayara/domain/model/response/bx_get_top_deals_response.dart';

///
/// Implementations call the remote get top deals endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetTopDealsRepositories {
  /// Fetches the top deals with the provided request.
  ///
  /// Returns a [BxGetTopDealsResponse] indicating success or failure.
  Future<BxGetTopDealsResponse> fetchTopDeals(BxGetTopDealsRequest request);
}
