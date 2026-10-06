/// Concrete implementation of [BxGetExploreTripsRepositories] that fetches
/// explore trips through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetExploreTripsResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/repositories/bx_get_explore_trips_repositories.dart';

// File: lib/data/repositories/bx_get_explore_trips_repositories_impl.dart
// Architecture: Data Layer - Bx Get Explore Trips Repository Implementation
// Purpose: Provides concrete implementation of the get explore trips interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetExploreTripsRepositoriesImpl
    implements BxGetExploreTripsRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetExploreTripsRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches explore trips by calling the remote endpoint.
  ///
  /// On success a [BxGetExploreTripsResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetExploreTripsResponse> fetchExploreTrips(
    BxGetExploreTripsRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchExploreTrips(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetExploreTripsResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetExploreTripsResponse(
        code: 500,
        msg: 'Failed to fetch explore trips. Please try again.',
        data: null,
      );
    }
  }
}
