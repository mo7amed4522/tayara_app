/// Concrete implementation of [BxActiveTopBannerAdsRepositories] that fetches
/// active top banner ads through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxActiveTopBannerAdsResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/repositories/bx_active_top_banner_ads_repositories.dart';

// File: lib/data/repositories/bx_active_top_banner_ads_repositories_impl.dart
// Architecture: Data Layer - Bx Active Top Banner Ads Repository Implementation
// Purpose: Provides concrete implementation of the active top banner ads interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxActiveTopBannerAdsRepositoriesImpl
    implements BxActiveTopBannerAdsRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxActiveTopBannerAdsRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches active top banner ads by calling the remote endpoint.
  ///
  /// On success a [BxActiveTopBannerAdsResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxActiveTopBannerAdsResponse> fetchActiveTopBannerAds(
    BxActiveTopBannerAdsRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchActiveTopBannerAds(
        request,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxActiveTopBannerAdsResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxActiveTopBannerAdsResponse(
        code: 500,
        msg: 'Failed to fetch active top banner ads. Please try again.',
        data: null,
      );
    }
  }
}
