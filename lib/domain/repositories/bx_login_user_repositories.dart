// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_login_user_repositories.dart
// Architecture: Domain Layer - Bx Login User Repository
// Purpose: Define the login user repository for the application

import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';

///
/// Implementations call the remote login user endpoint using the
/// user's credentials and return the outcome.
abstract class BxLoginUserRepositories {
  /// Fetches the login user with the provided request.
  ///
  /// Returns a [BxLoginUserResponse] indicating success or failure.
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request);
}
