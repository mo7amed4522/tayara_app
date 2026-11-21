/// Concrete implementation of [BxDeleteUserDataRepositories] that deletes the
/// current user's account through the remote data source.
///
/// Handles [BxNetworkException] explicitly by converting it into a
/// [BxDeleteUserDataResponse] with an error status, so callers always receive
/// a response object even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/response/bx_delete_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_delete_user_data_repositories.dart';

// File: lib/data/repositories/bx_delete_user_data_repositories_impl.dart
// Architecture: Data Layer - Bx Delete User Data Repository Implementation
// Purpose: Provides concrete implementation of the delete user data interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxDeleteUserDataRepositoriesImpl implements BxDeleteUserDataRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxDeleteUserDataRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Deletes the current user's account by calling the remote endpoint.
  ///
  /// On success a [BxDeleteUserDataResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 500 error response.
  @override
  Future<BxDeleteUserDataResponse> deleteUserData({
    required String token,
  }) async {
    try {
      final result = await _bxsystemRemoteDataSource.deleteUserData(
        token: token,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxDeleteUserDataResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxDeleteUserDataResponse(
        code: 500,
        msg: 'Failed to delete user account. Please try again.',
        data: null,
      );
    }
  }
}
