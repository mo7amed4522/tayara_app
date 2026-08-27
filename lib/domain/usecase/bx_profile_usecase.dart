// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_profile_usecase.dart
// Architecture: Domain Layer - Profile UseCase
// Purpose: Defines the profile use cases

import 'package:tayara/domain/model/response/bx_profile_response.dart';
import 'package:tayara/domain/repositories/bx_profile_repositories.dart';

class BxProfileUsecase {
  final BxProfileRepositories _repositories;

  BxProfileUsecase(this._repositories);

  Future<BxProfileResponse> loadProfile() => _repositories.loadProfile();
}
