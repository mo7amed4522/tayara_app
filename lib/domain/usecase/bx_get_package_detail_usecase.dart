// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_package_detail_usecase.dart
// Architecture: Domain Layer - Bx Get Package Detail UseCase
// Purpose: Defines the get package detail use case

import 'package:tayara/domain/model/request/bx_get_package_detail_request.dart';
import 'package:tayara/domain/model/response/bx_get_package_detail_response.dart';
import 'package:tayara/domain/repositories/bx_get_package_detail_repositories.dart';

/// Use case that fetches the explore package detail with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetExploreTripsResponse] indicating success or failure.
class BxGetPackageDetailUsecase {
  final BxGetPackageDetailRepositories repositories;

  /// Creates a [BxGetPackageDetailRepositories] with the necessary [repositories].
  BxGetPackageDetailUsecase(this.repositories);

  /// Fetches the explore package detail with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetPackageDetailResponse> execute(
    BxGetPackageDetailRequest request,
  ) {
    return repositories.fetchPackageDetails(request);
  }
}
