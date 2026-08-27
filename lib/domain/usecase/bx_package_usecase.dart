// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_package_usecase.dart
// Architecture: Domain Layer - Package UseCase
// Purpose: Defines the package use cases

import 'package:tayara/domain/model/response/bx_package_response.dart';
import 'package:tayara/domain/repositories/bx_package_repositories.dart';

class BxPackageUsecase {
  final BxPackageRepositories _repositories;

  BxPackageUsecase(this._repositories);

  Future<BxPackageDetailResponse> loadPackageDetail(int packageId) =>
      _repositories.loadPackageDetail(packageId);

  Future<BxPackageReviewsResponse> loadPackageReviews(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  }) => _repositories.loadPackageReviews(
    packageId,
    page: page,
    pageSize: pageSize,
  );
}
