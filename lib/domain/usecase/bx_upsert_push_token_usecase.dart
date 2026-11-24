// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_upsert_push_token_usecase.dart
// Architecture: Domain Layer - Bx Upsert Push Token UseCase
// Purpose: Defines the upsert push token use case

import 'package:tayara/domain/model/request/bx_upsert_push_token_request.dart';
import 'package:tayara/domain/model/response/bx_upsert_push_token_response.dart';
import 'package:tayara/domain/repositories/bx_upsert_push_token_repositories.dart';

/// Use case that registers or updates a device push token with the provided
/// request.
///
/// It invokes the repository with the upsert request and returns a
/// [BxUpsertPushTokenResponse] indicating success or failure.
class BxUpsertPushTokenUsecase {
  final BxUpsertPushTokenRepositories repositories;

  /// Creates a [BxUpsertPushTokenUsecase] with the necessary [repositories].
  BxUpsertPushTokenUsecase(this.repositories);

  /// Registers or updates the device push token with the provided request.
  ///
  /// Returns the server's upsert response.
  Future<BxUpsertPushTokenResponse> execute(BxUpsertPushTokenRequest request) {
    return repositories.upsertPushToken(request);
  }
}
