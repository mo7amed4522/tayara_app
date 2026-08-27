// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_package_repositories.dart
// Architecture: Domain Layer - Package Repository
// Purpose: Define the package repository interface for the application

import 'package:tayara/domain/model/response/bx_package_response.dart';

abstract class BxPackageRepositories {
  Future<BxPackageDetailResponse> loadPackageDetail(int packageId);
  Future<BxPackageReviewsResponse> loadPackageReviews(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  });
}
