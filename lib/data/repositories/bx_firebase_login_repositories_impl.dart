/// Concrete implementation of [BxFirebaseLoginRepositories] that logs in
/// the user through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxFirebaseLoginResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';
import 'package:tayara/domain/repositories/bx_firebase_login_repositories.dart';

// File: lib/data/repositories/bx_firebase_login_repositories_impl.dart
// Architecture: Data Layer - Bx Firebase Login Repository Implementation
// Purpose: Provides concrete implementation of the Firebase login interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxFirebaseLoginRepositoriesImpl implements BxFirebaseLoginRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxFirebaseLoginRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Logs in the user with the provided credentials by calling the remote
  /// endpoint.
  ///
  /// On success a [BxFirebaseLoginResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request) async {
    try {
      final result = await _bxsystemRemoteDataSource.loginUserFire(request);
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
        msg: 'Login failed. Please try again.',
        data: null,
      );
    }
  }
}
