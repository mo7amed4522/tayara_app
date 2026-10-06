/// Concrete implementation of [BxGetDestinationsRepositories] that fetches
/// destinations through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetDestinationsResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_destinations_request.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/repositories/bx_get_destinations_repositories.dart';

// File: lib/data/repositories/bx_get_destinations_repositories_impl.dart
// Architecture: Data Layer - Bx Get Destinations Repository Implementation
// Purpose: Provides concrete implementation of the get destinations interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetDestinationsRepositoriesImpl
    implements BxGetDestinationsRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetDestinationsRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches destinations by calling the remote endpoint.
  ///
  /// On success a [BxGetDestinationsResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetDestinationsResponse> fetchDestinations(
    BxGetDestinationsRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchDestinations(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetDestinationsResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetDestinationsResponse(
        code: 500,
        msg: 'Failed to fetch destinations. Please try again.',
        data: null,
      );
    }
  }
}
