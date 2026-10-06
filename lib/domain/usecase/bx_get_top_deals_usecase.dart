// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_top_deals_usecase.dart
// Architecture: Domain Layer - Bx Get Top Deals UseCase
// Purpose: Defines the get top deals use case

import 'package:tayara/domain/model/request/bx_get_top_deals_request.dart';
import 'package:tayara/domain/model/response/bx_get_top_deals_response.dart';
import 'package:tayara/domain/repositories/bx_get_top_deals_repositories.dart';

/// Use case that fetches the top deals with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetTopDealsResponse] indicating success or failure.
class BxGetTopDealsUsecase {
  final BxGetTopDealsRepositories repositories;

  /// Creates a [BxGetTopDealsUsecase] with the necessary [repositories].
  BxGetTopDealsUsecase(this.repositories);

  /// Fetches the top deals with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetTopDealsResponse> execute(BxGetTopDealsRequest request) {
    return repositories.fetchTopDeals(request);
  }
}
