/// Concrete implementation of [BxGetRecommendedForCustomerRepositories] that fetches
/// recommended items for the customer through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetRecommendedForCustomerResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_recommended_for_customer_request.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/repositories/bx_get_recommended_for_customer_repositories.dart';

// File: lib/data/repositories/bx_get_recommended_for_customer_repositories_impl.dart
// Architecture: Data Layer - Bx Get Recommended For Customer Repository Implementation
// Purpose: Provides concrete implementation of the get recommended for customer interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetRecommendedForCustomerRepositoriesImpl
    implements BxGetRecommendedForCustomerRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetRecommendedForCustomerRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches recommended items for the customer by calling the remote endpoint.
  ///
  /// On success a [BxGetRecommendedForCustomerResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetRecommendedForCustomerResponse> fetchRecommendedForCustomer(
    BxGetRecommendedForCustomerRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource
          .fetchRecommendedForCustomer(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetRecommendedForCustomerResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetRecommendedForCustomerResponse(
        code: 500,
        msg: 'Failed to fetch recommended items. Please try again.',
        data: null,
      );
    }
  }
}
