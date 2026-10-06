// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_firebase_login_repositories.dart
// Architecture: Domain Layer - Bx Firebase Login Repository
// Purpose: Define the Firebase login repository for the application

import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';

///
/// Implementations call the remote login endpoint using the
/// user's credentials and return the outcome.
abstract class BxFirebaseLoginRepositories {
  /// Logs in the user with the provided credentials.
  ///
  /// Returns a [BxLoginUserResponse] indicating success or failure.
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request);
}
