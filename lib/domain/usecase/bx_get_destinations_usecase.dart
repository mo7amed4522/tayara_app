// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_destinations_usecase.dart
// Architecture: Domain Layer - Bx Get Destinations UseCase
// Purpose: Defines the get destinations use case

import 'package:tayara/domain/model/request/bx_get_destinations_request.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/repositories/bx_get_destinations_repositories.dart';

/// Use case that fetches the destinations with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetDestinationsResponse] indicating success or failure.
class BxGetDestinationsUsecase {
  final BxGetDestinationsRepositories repositories;

  /// Creates a [BxGetDestinationsUsecase] with the necessary [repositories].
  BxGetDestinationsUsecase(this.repositories);

  /// Fetches the destinations with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetDestinationsResponse> execute(BxGetDestinationsRequest request) {
    return repositories.fetchDestinations(request);
  }
}
