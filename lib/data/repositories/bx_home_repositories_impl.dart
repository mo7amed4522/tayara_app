// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_home_repositories_impl.dart
// Architecture: Data Layer - Home Repository Implementation
// Purpose: Provides concrete implementation of the home repository interface

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/repositories/bx_home_repositories.dart';

class BxHomeRepositoriesImpl implements BxHomeRepositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  BxHomeRepositoriesImpl({required BxSystemRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<BxAdsResult> loadHomeAds() => _remoteDataSource.loadHomeAds();

  @override
  Future<BxDestinationsResult> loadDestinations() =>
      _remoteDataSource.loadDestinations();

  @override
  Future<BxExploreTripsResult> loadExploreTrips(
    BxCustomerExploreRequest request,
  ) => _remoteDataSource.loadExploreTrips(request);

  @override
  Future<BxDealsResult> loadDeals(BxCustomerDealsRequest request) =>
      _remoteDataSource.loadDeals(request);

  @override
  Future<BxAgentsResult> loadTopRatedAgents() =>
      _remoteDataSource.loadTopRatedAgents();

  @override
  Future<BxRecommendedResult> loadRecommended() =>
      _remoteDataSource.loadRecommended();

  @override
  Future<BxSearchResult> search(BxCustomerSearchRequest request) =>
      _remoteDataSource.search(request);
}
