// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_active_top_banner_ads_usecase.dart
// Architecture: Domain Layer - Bx Active Top Banner Ads UseCase
// Purpose: Defines the active top banner ads use case

import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/repositories/bx_active_top_banner_ads_repositories.dart';

/// Use case that fetches the active top banner ads with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxActiveTopBannerAdsResponse] indicating success or failure.
class BxActiveTopBannerAdsUsecase {
  final BxActiveTopBannerAdsRepositories repositories;

  /// Creates a [BxActiveTopBannerAdsUsecase] with the necessary [repositories].
  BxActiveTopBannerAdsUsecase(this.repositories);

  /// Fetches the active top banner ads with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxActiveTopBannerAdsResponse> execute(
    BxActiveTopBannerAdsRequest request,
  ) {
    return repositories.fetchActiveTopBannerAds(request);
  }
}
