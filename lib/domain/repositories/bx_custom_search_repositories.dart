// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_custom_search_repositories.dart
// Architecture: Domain Layer - Bx Custom Search Repository
// Purpose: Define the search countru/city repository for the application

import 'package:tayara/domain/model/request/bx_custom_search_request.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';

///
/// Implementations call the remote custom search endpoint using the
/// user's credentials and return the outcome.
abstract class BxCustomSearchRepositories {
  /// Fetches the search that user want with the provided request.
  ///
  /// Returns a [BxCustomSearchResponse] indicating success or failure.
  Future<BxCustomSearchResponse> fetchCustomSearch(
    BxCustomSearchRequest request,
  );
}
