// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_search_repositories.dart
// Architecture: Domain Layer - Bx Get Search Repository
// Purpose: Define the get search repository for the application

import 'package:tayara/domain/model/request/bx_get_search_request.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';

///
/// Implementations call the remote get search endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetSearchRepositories {
  /// Fetches the search results with the provided request.
  ///
  /// Returns a [BxGetSearchResponse] indicating success or failure.
  Future<BxGetSearchResponse> fetchSearchResults(BxGetSearchRequest request);
}
