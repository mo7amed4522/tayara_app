/// Concrete implementation of [BxGetUserDataRepositories] that fetches the
/// current user's profile through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetUserDataResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/response/bx_get_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_get_user_data_repositories.dart';

// File: lib/data/repositories/bx_get_user_data_repositories_impl.dart
// Architecture: Data Layer - Bx Get User Data Repository Implementation
// Purpose: Provides concrete implementation of the get user data interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetUserDataRepositoriesImpl implements BxGetUserDataRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetUserDataRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches the current user's profile by calling the remote endpoint.
  ///
  /// On success a [BxGetUserDataResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 500 error response.
  @override
  Future<BxGetUserDataResponse> fetchUserData(String token) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchUserData(token);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetUserDataResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetUserDataResponse(
        code: 500,
        msg: 'Failed to fetch user data. Please try again.',
        data: null,
      );
    }
  }
}
