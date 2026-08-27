// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_home_usecase.dart
// Architecture: Domain Layer - Home UseCase
// Purpose: Defines the home use cases

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/repositories/bx_home_repositories.dart';

class BxHomeUsecase {
  final BxHomeRepositories _repositories;

  BxHomeUsecase(this._repositories);

  Future<BxAdsResult> loadHomeAds() => _repositories.loadHomeAds();
  Future<BxDestinationsResult> loadDestinations() =>
      _repositories.loadDestinations();
  Future<BxExploreTripsResult> loadExploreTrips(
    BxCustomerExploreRequest request,
  ) => _repositories.loadExploreTrips(request);
  Future<BxDealsResult> loadDeals(BxCustomerDealsRequest request) =>
      _repositories.loadDeals(request);
  Future<BxAgentsResult> loadTopRatedAgents() =>
      _repositories.loadTopRatedAgents();
  Future<BxRecommendedResult> loadRecommended() =>
      _repositories.loadRecommended();
  Future<BxSearchResult> search(BxCustomerSearchRequest request) =>
      _repositories.search(request);
}
