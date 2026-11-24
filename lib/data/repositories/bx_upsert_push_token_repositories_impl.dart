// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_upsert_push_token_repositories_impl.dart
// Architecture: Data Layer - Bx Upsert Push Token Repository Implementation
// Purpose: Provides concrete implementation of the upsert push token interface using remote data source

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_upsert_push_token_request.dart';
import 'package:tayara/domain/model/response/bx_upsert_push_token_response.dart';
import 'package:tayara/domain/repositories/bx_upsert_push_token_repositories.dart';

/// Concrete implementation of [BxUpsertPushTokenRepositories] that registers
/// or updates a device push token through the remote data source.
class BxUpsertPushTokenRepositoriesImpl
    implements BxUpsertPushTokenRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxUpsertPushTokenRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Upserts the device push token by calling the remote endpoint.
  ///
  /// On success a [BxUpsertPushTokenResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 500 error response.
  @override
  Future<BxUpsertPushTokenResponse> upsertPushToken(
    BxUpsertPushTokenRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.upsertPushToken(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxUpsertPushTokenResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxUpsertPushTokenResponse(
        code: 500,
        msg: 'Failed to register push token. Please try again.',
        data: null,
      );
    }
  }
}
