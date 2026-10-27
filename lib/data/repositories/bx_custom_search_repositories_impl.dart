/// Concrete implementation of [BxCustomSearchRepositories] that fetches
/// cusotm search data through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxCustomSearchResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_custom_search_request.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';
import 'package:tayara/domain/repositories/bx_custom_search_repositories.dart';

// File: lib/data/repositories/bx_custom_search_repositories_impl.dart
// Architecture: Data Layer - Bx Get Custom Search Repository Implementation
// Purpose: Provides concrete implementation of the get custom search interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxCustomSearchRepositoriesImpl implements BxCustomSearchRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxCustomSearchRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches custom search data by calling the remote endpoint.
  ///
  /// On success a [BxCustomSearchResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxCustomSearchResponse> fetchCustomSearch(
    BxCustomSearchRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchCustomSearch(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxCustomSearchResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxCustomSearchResponse(
        code: 500,
        msg: 'Failed to fetch custom search data. Please try again.',
        data: null,
      );
    }
  }
}
