// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_search_usecase.dart
// Architecture: Domain Layer - Bx Get Search UseCase
// Purpose: Defines the get search use case

import 'package:tayara/domain/model/request/bx_get_search_request.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';
import 'package:tayara/domain/repositories/bx_get_search_repositories.dart';

/// Use case that fetches the search results with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetSearchResponse] indicating success or failure.
class BxGetSearchUsecase {
  final BxGetSearchRepositories repositories;

  /// Creates a [BxGetSearchUsecase] with the necessary [repositories].
  BxGetSearchUsecase(this.repositories);

  /// Fetches the search results with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetSearchResponse> execute(BxGetSearchRequest request) {
    return repositories.fetchSearchResults(request);
  }
}
