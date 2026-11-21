// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_user_data_repositories.dart
// Architecture: Domain Layer - Bx Get User Data Repository
// Purpose: Define the current user's profile repository for the application

import 'package:tayara/domain/model/response/bx_get_user_data_response.dart';

///
/// Implementations call the remote get user data endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetUserDataRepositories {
  /// Fetches the current user's profile with the provided request.
  ///
  /// Returns a [BxGetUserDataResponse] indicating success or failure.
  Future<BxGetUserDataResponse> fetchUserData(String token);
}
