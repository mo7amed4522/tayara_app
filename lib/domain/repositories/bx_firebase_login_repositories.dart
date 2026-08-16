// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_firebase_login_repositories.dart
// Architecture: Domain Layer - Bx Firebase Login Repository
// Purpose: Define the Firebase login repository for the application

import 'package:tayara/domain/model/request/bx_firebase_login_request.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';

///
/// Implementations call the remote login endpoint using the
/// user's credentials and return the outcome.
abstract class BxFirebaseLoginRepositories {
  /// Logs in the user with the provided credentials.
  ///
  /// Returns a [BxFirebaseLoginResponse] indicating success or failure.
  Future<BxFirebaseLoginResponse> loginUser(BxFirebaseLoginRequest request);
}
