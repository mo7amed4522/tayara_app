// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_destinations_repositories.dart
// Architecture: Domain Layer - Bx Get Destinations Repository
// Purpose: Define the get destinations repository for the application

import 'package:tayara/domain/model/request/bx_get_destinations_request.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';

///
/// Implementations call the remote get destinations endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetDestinationsRepositories {
  /// Fetches the destinations with the provided request.
  ///
  /// Returns a [BxGetDestinationsResponse] indicating success or failure.
  Future<BxGetDestinationsResponse> fetchDestinations(
    BxGetDestinationsRequest request,
  );
}
