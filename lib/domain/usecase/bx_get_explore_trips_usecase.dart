// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_explore_trips_usecase.dart
// Architecture: Domain Layer - Bx Get Explore Trips UseCase
// Purpose: Defines the get explore trips use case

import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/repositories/bx_get_explore_trips_repositories.dart';

/// Use case that fetches the explore trips with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetExploreTripsResponse] indicating success or failure.
class BxGetExploreTripsUsecase {
  final BxGetExploreTripsRepositories repositories;

  /// Creates a [BxGetExploreTripsUsecase] with the necessary [repositories].
  BxGetExploreTripsUsecase(this.repositories);

  /// Fetches the explore trips with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetExploreTripsResponse> execute(BxGetExploreTripsRequest request) {
    return repositories.fetchExploreTrips(request);
  }
}
