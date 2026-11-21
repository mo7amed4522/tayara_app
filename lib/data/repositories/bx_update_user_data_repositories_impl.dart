/// Concrete implementation of [BxUpdateUserDataRepositories] that updates the
/// current user's profile through the remote data source.
///
/// Handles [BxNetworkException] explicitly by converting it into a
/// [BxUpdateUserDataResponse] with an error status, so callers always receive
/// a response object even when the network call fails.
///
library;

import 'package:image_picker/image_picker.dart';
import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/response/bx_update_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_update_user_data_repositories.dart';

// File: lib/data/repositories/bx_update_user_data_repositories_impl.dart
// Architecture: Data Layer - Bx Update User Data Repository Implementation
// Purpose: Provides concrete implementation of the update user data interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxUpdateUserDataRepositoriesImpl implements BxUpdateUserDataRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxUpdateUserDataRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Updates the current user's profile by calling the remote endpoint.
  ///
  /// On success a [BxUpdateUserDataResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 500 error response.
  @override
  Future<BxUpdateUserDataResponse> updateUserData({
    required String token,
    required Map<String, dynamic> body,
    XFile? headerImage,
  }) async {
    try {
      final result = await _bxsystemRemoteDataSource.updateUserData(
        token: token,
        body: body,
        headerImage: headerImage,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxUpdateUserDataResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxUpdateUserDataResponse(
        code: 500,
        msg: 'Failed to update user data. Please try again.',
        data: null,
      );
    }
  }
}
