// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_update_user_data_usecase.dart
// Architecture: Domain Layer - Bx Update User Data UseCase
// Purpose: Defines the update user data use case

import 'package:image_picker/image_picker.dart';
import 'package:tayara/domain/model/response/bx_update_user_data_response.dart';
import 'package:tayara/domain/repositories/bx_update_user_data_repositories.dart';

/// Use case that updates the current user's profile.
///
/// It invokes the repository and returns a [BxUpdateUserDataResponse]
/// indicating success or failure.
class BxUpdateUserDataUsecase {
  final BxUpdateUserDataRepositories repositories;

  /// Creates a [BxUpdateUserDataUsecase] with the necessary [repositories].
  BxUpdateUserDataUsecase(this.repositories);

  /// Updates the current user's profile.
  ///
  /// Returns the server's update response.
  /// [headerImage] is optional for profile image upload.
  Future<BxUpdateUserDataResponse> execute({
    required String token,
    required Map<String, dynamic> body,
    XFile? headerImage,
  }) {
    return repositories.updateUserData(
      token: token,
      body: body,
      headerImage: headerImage,
    );
  }
}
