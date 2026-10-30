// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_package_detail_repositories.dart
// Architecture: Domain Layer - Bx Get Package Detail Repository
// Purpose: Define the get package detail repository for the application

import 'package:tayara/domain/model/request/bx_get_package_detail_request.dart';
import 'package:tayara/domain/model/response/bx_get_package_detail_response.dart';

///
/// Implementations call the remote get package detail endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetPackageDetailRepositories {
  /// Fetches the get package detail with the provided request.
  ///
  /// Returns a [BxGetPackageDetailResponse] indicating success or failure.
  Future<BxGetPackageDetailResponse> fetchPackageDetails(
    BxGetPackageDetailRequest request,
  );
}
