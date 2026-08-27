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

  // login url endpoint
  /// POST endpoint for user login.
  static String get loginUrl =>
      '/api/${BxAppData.appVersion}/user/firebase-login';

  // trip detail endpoint
  /// POST endpoint for fetching trip detail by ID.
  static String get tripDetailUrl => '/api/${BxAppData.appVersion}/trip/detail';

  // filter trips endpoint
  /// POST endpoint for filtering trips by criteria.
  static String get filterTripsUrl =>
      '/api/${BxAppData.appVersion}/trip/filter';

  // booking endpoints
  /// POST endpoint for fetching booking detail.
  static String get bookingDetailUrl =>
      '/api/${BxAppData.appVersion}/booking/detail';

  /// POST endpoint for cancelling a booking.
  static String get cancelBookingUrl =>
      '/api/${BxAppData.appVersion}/booking/cancel';

  // payment endpoint
  /// POST endpoint for processing a payment.
  static String get paymentUrl =>
      '/api/${BxAppData.appVersion}/payment/process';

  // ── Home ────────────────────────────────────────────────────────────────────

  /// GET endpoint for home ad banners.
  static String get homeAdsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/ads';

  /// GET endpoint for home destinations.
  static String get homeDestinationsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/destinations';

  /// GET endpoint for explore trips.
  static String get exploreTripsUrl =>
      '/api/${BxAppData.appVersion}/customer/explore/trips';

  /// GET endpoint for home deals.
  static String get homeDealsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/deals';

  /// GET endpoint for top rated agents.
  static String get homeAgentsUrl =>
      '/api/${BxAppData.appVersion}/customer/home/agents';

  /// GET endpoint for recommended packages (auth required).
  static String get homeRecommendedUrl =>
      '/api/${BxAppData.appVersion}/customer/home/recommended';

  /// GET endpoint for customer search.
  static String customerSearchUrl(
    String keyword, {
    int page = 1,
    int pageSize = 10,
  }) =>
      '/api/${BxAppData.appVersion}/customer/search?keyword=${Uri.encodeComponent(keyword)}&page=$page&pageSize=$pageSize';

  // ── Package Detail ──────────────────────────────────────────────────────────

  /// GET endpoint for package detail.
  static String packageDetailUrl(int packageId) =>
      '/api/${BxAppData.appVersion}/customer/packages/detail?id=$packageId';

  /// GET endpoint for package reviews.
  static String packageReviewsUrl(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  }) =>
      '/api/${BxAppData.appVersion}/customer/packages/detail/reviews?packageId=$packageId&page=$page&pageSize=$pageSize';

  // ── Agent Detail ────────────────────────────────────────────────────────────

  /// GET endpoint for agent detail.
  static String agentDetailUrl(
    int agentId, {
    int page = 1,
    int pageSize = 12,
  }) =>
      '/api/${BxAppData.appVersion}/customer/agent/detail?agentId=$agentId&page=$page&pageSize=$pageSize';

  // ── Profile ─────────────────────────────────────────────────────────────────

  /// GET endpoint for user profile (auth required).
  static String get userProfileUrl =>
      '/api/${BxAppData.appVersion}/user/profile';

  // ── Booking ─────────────────────────────────────────────────────────────────

  /// GET endpoint for listing own bookings.
  static String get bookingListUrl => '/api/${BxAppData.appVersion}/booking';
}
