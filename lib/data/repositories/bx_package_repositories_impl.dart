// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_package_repositories_impl.dart
// Architecture: Data Layer - Package Repository Implementation
// Purpose: Provides concrete implementation of the package repository interface

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/response/bx_package_response.dart';
import 'package:tayara/domain/repositories/bx_package_repositories.dart';

class BxPackageRepositoriesImpl implements BxPackageRepositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  BxPackageRepositoriesImpl({
    required BxSystemRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<BxPackageDetailResponse> loadPackageDetail(int packageId) =>
      _remoteDataSource.loadPackageDetail(packageId);

  @override
  Future<BxPackageReviewsResponse> loadPackageReviews(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  }) => _remoteDataSource.loadPackageReviews(
    packageId,
    page: page,
    pageSize: pageSize,
  );
}
