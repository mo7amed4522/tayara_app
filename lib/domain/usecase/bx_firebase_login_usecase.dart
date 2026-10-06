// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_firebase_login_usecase.dart
// Architecture: Domain Layer - Bx Firebase Login UseCase
// Purpose: Defines the Firebase login use case

import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';
import 'package:tayara/domain/repositories/bx_firebase_login_repositories.dart';

/// Use case that logs in the user with the provided credentials.
///
/// It invokes the repository with the login request and returns a
/// [BxLoginUserResponse] indicating success or failure.
class BxFirebaseLoginUsecase {
  final BxFirebaseLoginRepositories repositories;

  /// Creates a [BxFirebaseLoginUsecase] with the necessary [repositories].
  BxFirebaseLoginUsecase(this.repositories);

  /// Logs in the user with the provided credentials.
  ///
  /// Returns the server's login response.
  Future<BxLoginUserResponse> execute(BxLoginUserRequest request) {
    return repositories.loginUser(request);
  }
}
