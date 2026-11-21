// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_update_user_data_repositories.dart
// Architecture: Domain Layer - Bx Update User Data Repository
// Purpose: Define the update user data repository for the application

import 'package:image_picker/image_picker.dart';
import 'package:tayara/domain/model/response/bx_update_user_data_response.dart';

///
/// Implementations call the remote update user data endpoint using the
/// user's credentials and return the outcome.
abstract class BxUpdateUserDataRepositories {
  /// Updates the current user's profile with the provided fields.
  ///
  /// [token] is the authentication token.
  /// [body] contains the profile fields to update.
  /// [headerImage] is optional for profile image upload.
  ///
  /// Returns a [BxUpdateUserDataResponse] indicating success or failure.
  Future<BxUpdateUserDataResponse> updateUserData({
    required String token,
    required Map<String, dynamic> body,
    XFile? headerImage,
  });
}
