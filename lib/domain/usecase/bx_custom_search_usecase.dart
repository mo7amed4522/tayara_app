// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_custom_search_usecase.dart
// Architecture: Domain Layer - Bx Custom Search UseCase
// Purpose: Defines the search data use case

import 'package:tayara/domain/model/request/bx_custom_search_request.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';
import 'package:tayara/domain/repositories/bx_custom_search_repositories.dart';

/// Use case that fetches the search city/country with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxCustomSearchResponse] indicating success or failure.
class BxCustomSearchUsecase {
  final BxCustomSearchRepositories repositories;

  /// Creates a [BxCustomSearchUsecase] with the necessary [repositories].
  BxCustomSearchUsecase(this.repositories);

  /// Fetches the custom search city/country with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxCustomSearchResponse> execute(BxCustomSearchRequest request) {
    return repositories.fetchCustomSearch(request);
  }
}
