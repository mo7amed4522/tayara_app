// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_delete_user_data_usecase.dart
// Architecture: Domain Layer - Bx Delete User Data UseCase
// Purpose: Defines the delete user data use case

import 'package:tayara/domain/model/response/bx_delete_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_delete_user_data_repositories.dart';

/// Use case that deletes the current user's account.
///
/// It invokes the repository and returns a [BxDeleteUserDataResponse]
/// indicating success or failure.
class BxDeleteUserDataUsecase {
  final BxDeleteUserDataRepositories repositories;

  /// Creates a [BxDeleteUserDataUsecase] with the necessary [repositories].
  BxDeleteUserDataUsecase(this.repositories);

  /// Deletes the current user's account.
  ///
  /// Returns the server's delete response.
  Future<BxDeleteUserDataResponse> execute({required String token}) {
    return repositories.deleteUserData(token: token);
  }
}
