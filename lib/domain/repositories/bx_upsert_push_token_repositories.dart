// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_upsert_push_token_repositories.dart
// Architecture: Domain Layer - Bx Upsert Push Token Repository
// Purpose: Define the upsert push token repository for the application

import 'package:tayara/domain/model/request/bx_upsert_push_token_request.dart';
import 'package:tayara/domain/model/response/bx_upsert_push_token_response.dart';

///
/// Implementations call the remote upsert push token endpoint using the
/// user's credentials and return the outcome.
abstract class BxUpsertPushTokenRepositories {
  /// Registers or updates the device push token with the provided request.
  ///
  /// Returns a [BxUpsertPushTokenResponse] indicating success or failure.
  Future<BxUpsertPushTokenResponse> upsertPushToken(
    BxUpsertPushTokenRequest request,
  );
}
