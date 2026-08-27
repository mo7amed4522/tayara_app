// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_profile_repositories.dart
// Architecture: Domain Layer - Profile Repository
// Purpose: Define the profile repository interface for the application

import 'package:tayara/domain/model/response/bx_profile_response.dart';

abstract class BxProfileRepositories {
  Future<BxProfileResponse> loadProfile();
}
