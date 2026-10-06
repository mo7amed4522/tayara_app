// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_login_user_usecase.dart
// Architecture: Domain Layer - Bx Login User UseCase
// Purpose: Defines the login user use case

import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';
import 'package:tayara/domain/repositories/bx_login_user_repositories.dart';

/// Use case that fetches the login user with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxLoginUserResponse] indicating success or failure.
class BxLoginUserUsecase {
  final BxLoginUserRepositories repositories;

  /// Creates a [BxLoginUserUsecase] with the necessary [repositories].
  BxLoginUserUsecase(this.repositories);

  /// Fetches the login user with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxLoginUserResponse> execute(BxLoginUserRequest request) {
    return repositories.loginUser(request);
  }
}
