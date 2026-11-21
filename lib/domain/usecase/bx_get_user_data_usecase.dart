// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_user_data_usecase.dart
// Architecture: Domain Layer - Bx Get User Data UseCase
// Purpose: Defines the current user's profile use case

import 'package:tayara/domain/model/response/bx_get_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_get_user_data_repositories.dart';

/// Use case that fetches the current user's profile with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetUserDataResponse] indicating success or failure.
class BxGetUserDataUsecase {
  final BxGetUserDataRepositories repositories;

  /// Creates a [BxGetUserDataUsecase] with the necessary [repositories].
  BxGetUserDataUsecase(this.repositories);

  /// Fetches the current user's profile with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetUserDataResponse> execute(String token) {
    return repositories.fetchUserData(token);
  }
}
