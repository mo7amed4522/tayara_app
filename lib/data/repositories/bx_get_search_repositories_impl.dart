/// Concrete implementation of [BxGetSearchRepositories] that fetches
/// search results through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetSearchResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_search_request.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';
import 'package:tayara/domain/repositories/bx_get_search_repositories.dart';

// File: lib/data/repositories/bx_get_search_repositories_impl.dart
// Architecture: Data Layer - Bx Get Search Repository Implementation
// Purpose: Provides concrete implementation of the get search interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetSearchRepositoriesImpl implements BxGetSearchRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetSearchRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches search results by calling the remote endpoint.
  ///
  /// On success a [BxGetSearchResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetSearchResponse> fetchSearchResults(
    BxGetSearchRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchSearchResults(
        request,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxGetSearchResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetSearchResponse(
        code: 500,
        msg: 'Failed to fetch search results. Please try again.',
        data: null,
      );
    }
  }
}
