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
  static String get tripDetailUrl =>
      '/api/${BxAppData.appVersion}/trip/detail';

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
}
