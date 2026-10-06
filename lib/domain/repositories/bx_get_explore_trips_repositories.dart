// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_explore_trips_repositories.dart
// Architecture: Domain Layer - Bx Get Explore Trips Repository
// Purpose: Define the get explore trips repository for the application

import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';

///
/// Implementations call the remote get explore trips endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetExploreTripsRepositories {
  /// Fetches the explore trips with the provided request.
  ///
  /// Returns a [BxGetExploreTripsResponse] indicating success or failure.
  Future<BxGetExploreTripsResponse> fetchExploreTrips(
    BxGetExploreTripsRequest request,
  );
}
