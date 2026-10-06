// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_active_top_banner_ads_repositories.dart
// Architecture: Domain Layer - Bx Active Top Banner Ads Repository
// Purpose: Define the active top banner ads repository for the application

import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';

///
/// Implementations call the remote active top banner ads endpoint using the
/// user's credentials and return the outcome.
abstract class BxActiveTopBannerAdsRepositories {
  /// Fetches the active top banner ads with the provided request.
  ///
  /// Returns a [BxActiveTopBannerAdsResponse] indicating success or failure.
  Future<BxActiveTopBannerAdsResponse> fetchActiveTopBannerAds(
    BxActiveTopBannerAdsRequest request,
  );
}
