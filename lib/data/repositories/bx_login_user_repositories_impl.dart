/// Concrete implementation of [BxLoginUserRepositories] that fetches
/// login user data through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxLoginUserResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';
import 'package:tayara/domain/repositories/bx_login_user_repositories.dart';

// File: lib/data/repositories/bx_login_user_repositories_impl.dart
// Architecture: Data Layer - Bx Login User Repository Implementation
// Purpose: Provides concrete implementation of the login user interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxLoginUserRepositoriesImpl implements BxLoginUserRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxLoginUserRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches login user data by calling the remote endpoint.
  ///
  /// On success a [BxLoginUserResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request) async {
    try {
      final result = await _bxsystemRemoteDataSource.loginUser(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxLoginUserResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxLoginUserResponse(
        code: 500,
        msg: 'Failed to fetch login user data. Please try again.',
        data: null,
      );
    }
  }
}
