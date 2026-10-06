// Copyright (c) 2026 Tayara. All rights reserved.
//
import 'package:tayara/core/constant/bx_app_constant.dart';

/// Centralised definition of the application's base URL and all REST API
/// endpoint paths.
///
/// All endpoints are relative to the base URL defined in [BxAppConfig].
/// The classes are non‑instantiable and designed to be used statically
/// throughout the application, avoiding hard‑coded URL strings.
///
/// File: lib/core/network/bx_api_endpoints.dart
/// Architecture: Core Layer - Bx API Endpoints
/// Purpose: Define the API endpoints for the application
class BxAppConfig {
  /// The Test URL of the backend API (staging environment).
  static const String baseUrl =
      'http://localhost:8888'; // Base URL for the API, can be switched to production when needed
}

/// Provides static getters for every API endpoint used by the application.
///
/// All paths are relative to [BxAppConfig.baseUrl].  Methods that require
/// path or query parameters accept them as arguments and return the fully
/// assembled relative URL.
///
/// This class cannot be instantiated.
class BxApiEndpoints {
  BxApiEndpoints._();

  /// Convenience getter that returns the same value as [BxAppConfig.baseUrl].
  static String get baseUrl => BxAppConfig.baseUrl;

  /// login url endpoint
  /// [POST] endpoint for user login.
  static String get loginUrl =>
      '/api/${BxAppData.appVersion}/user/firebase-login';

  /// login customer url endpoint
  /// [POST] endpoint for customer login.
  static String get loginCustomerUrl =>
      '/api/${BxAppData.appVersion}/user/login';

  /// home ads url endpoint
  /// [GET] endpoint for fetching home ads.
  static String get homeAdsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/ads';

  /// home destinations url endpoint
  /// [GET] endpoint for fetching home destinations.
  static String get homeDestinationsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/destinations';

  /// home explore trips url endpoint
  /// [GET] endpoint for fetching home explore trips.
  static String get homeExploreTripsUrl =>
      '/api/${BxAppData.appVersion}/customer/explore/trips';

  /// home get top deals url endpoint
  /// [GET] endpoint for fetching home get top deals.
  static String get homeTopDealsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/deals';

  /// home get top agents url endpoint
  /// [GET] endpoint for fetching home get top agents.
  static String get homeTopAgentsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/agents';

  /// home search url endpoint
  /// [GET] endpoint for fetching home search results.
  static String get homeSearchUrl =>
      '/api/${BxAppData.appVersion}/customer/search';

  /// home recommendation url endpoint
  /// [GET] endpoint for fetching home recommendation results.
  static String get homeRecommendationUrl =>
      '/api/${BxAppData.appVersion}/customer/home/recommended';
}
