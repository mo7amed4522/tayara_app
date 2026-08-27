// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_home_repositories.dart
// Architecture: Domain Layer - Home Repository
// Purpose: Define the home repository interface for the application

import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';

abstract class BxHomeRepositories {
  Future<BxAdsResult> loadHomeAds();
  Future<BxDestinationsResult> loadDestinations();
  Future<BxExploreTripsResult> loadExploreTrips(
    BxCustomerExploreRequest request,
  );
  Future<BxDealsResult> loadDeals(BxCustomerDealsRequest request);
  Future<BxAgentsResult> loadTopRatedAgents();
  Future<BxRecommendedResult> loadRecommended();
  Future<BxSearchResult> search(BxCustomerSearchRequest request);
}
