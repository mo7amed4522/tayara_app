// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_delete_user_data_repositories.dart
// Architecture: Domain Layer - Bx Delete User Data Repository
// Purpose: Define the delete user data repository for the application

import 'package:tayara/domain/model/response/bx_delete_user_data_response.dart';

///
/// Implementations call the remote delete user data endpoint using the
/// user's credentials and return the outcome.
abstract class BxDeleteUserDataRepositories {
  /// Deletes the current user's account.
  ///
  /// Returns a [BxDeleteUserDataResponse] indicating success or failure.
  Future<BxDeleteUserDataResponse> deleteUserData({required String token});
}
