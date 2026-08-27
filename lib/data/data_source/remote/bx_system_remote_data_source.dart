// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/data_source/remote/bx_system_remote_data_source.dart
// Architecture: Data Layer - Bx System Remote Data Source
// Purpose: Abstract contract and concrete implementation for all remote API calls

// ignore_for_file: prefer_initializing_formals, unused_field

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tayara/core/network/bx_api_endpoints.dart';
import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/domain/model/request/bx_firebase_login_request.dart';
import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/model/request/bx_booking_request.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';
import 'package:tayara/domain/model/response/bx_home_response.dart';
import 'package:tayara/domain/model/response/bx_agent_response.dart';
import 'package:tayara/domain/model/response/bx_package_response.dart';
import 'package:tayara/domain/model/response/bx_booking_response.dart';
import 'package:tayara/domain/model/response/bx_profile_response.dart';

/// Helper: decodes a Dio response into a Map<String, dynamic>.
/// Handles both Map responses and String (raw JSON) responses.
Map<String, dynamic> _decodeResponse(dynamic response) {
  if (response is Map<String, dynamic>) return response;
  if (response is String) {
    try {
      final decoded = jsonDecode(response);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
  }
  throw const FormatException('Unexpected response type');
}

/// Defines the contract for remote API calls across the application.
///
/// Every method returns a response object *without throwing exceptions*;
/// network and server errors are captured inside the response model's
/// status/code fields, allowing callers to handle errors uniformly.
abstract class BxSystemRemoteDataSource {
  // ── Auth ────────────────────────────────────────────────────────────────────

  /// Logs in the user with the provided credentials.
  Future<BxFirebaseLoginResponse> loginUser(BxFirebaseLoginRequest request);

  // ── Home ────────────────────────────────────────────────────────────────────

  /// Fetches active ad banners for the home screen.
  Future<BxAdsResult> loadHomeAds();

  /// Fetches destination cards for the explore screen.
  Future<BxDestinationsResult> loadDestinations();

  /// Fetches explore trips with optional category filter.
  Future<BxExploreTripsResult> loadExploreTrips(
    BxCustomerExploreRequest request,
  );

  /// Fetches home deals with optional category filter.
  Future<BxDealsResult> loadDeals(BxCustomerDealsRequest request);

  /// Fetches top rated agents.
  Future<BxAgentsResult> loadTopRatedAgents();

  /// Fetches recommended packages for the current user.
  Future<BxRecommendedResult> loadRecommended();

  /// Searches for agents, packages, and top explore results.
  Future<BxSearchResult> search(BxCustomerSearchRequest request);

  // ── Package Detail ──────────────────────────────────────────────────────────

  /// Fetches package detail by ID.
  Future<BxPackageDetailResponse> loadPackageDetail(int packageId);

  /// Fetches package reviews with pagination.
  Future<BxPackageReviewsResponse> loadPackageReviews(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  });

  // ── Agent Detail ────────────────────────────────────────────────────────────

  /// Fetches agent detail with packages and reviews.
  Future<BxCustomerAgentDetailResponse> loadAgentDetail(
    BxCustomerAgentDetailRequest request,
  );

  // ── Profile ─────────────────────────────────────────────────────────────────

  /// Fetches the authenticated user's profile.
  Future<BxProfileResponse> loadProfile();

  // ── Booking ─────────────────────────────────────────────────────────────────

  /// Lists the authenticated user's bookings.
  Future<BxBookingListResponse> loadBookings();

  /// Creates a new booking.
  Future<BxBookingDetailResponse> createBooking(BxCreateBookingRequest request);

  /// Fetches booking detail by ID.
  Future<BxBookingDetailResponse> loadBookingDetail(int bookingId);

  /// Cancels a booking.
  Future<BxCancelBookingResult> cancelBooking(BxCancelBookingRequest request);
}

// ── Result Models (non-serialisable, consumed by BLoCs) ──────────────────────

/// Holds the result of a home ads API call.
class BxAdsResult {
  final List<BxAdBannerResult> ads;
  final String? errorMessage;
  BxAdsResult({required this.ads, this.errorMessage});
}

/// Holds the result of a destinations API call.
class BxDestinationsResult {
  final List<BxCustomerDestinationCard> destinations;
  final String? errorMessage;
  BxDestinationsResult({required this.destinations, this.errorMessage});
}

/// Holds the result of an explore trips API call.
class BxExploreTripsResult {
  final List<BxCustomerExploreResult> trips;
  final String? errorMessage;
  BxExploreTripsResult({required this.trips, this.errorMessage});
}

/// Holds the result of a deals API call.
class BxDealsResult {
  final List<BxCustomerDealResult> deals;
  final String? errorMessage;
  BxDealsResult({required this.deals, this.errorMessage});
}

/// Holds the result of a top-rated agents API call.
class BxAgentsResult {
  final List<BxCustomerAgentCard> agents;
  final String? errorMessage;
  BxAgentsResult({required this.agents, this.errorMessage});
}

/// Holds the result of a recommended packages API call.
class BxRecommendedResult {
  final List<BxCustomerRecommendedResult> packages;
  final String? errorMessage;
  BxRecommendedResult({required this.packages, this.errorMessage});
}

/// Holds the result of a search API call.
class BxSearchResult {
  final List<BxCustomerAgentResult>? agents;
  final List<BxCustomerPackageResult>? packages;
  final List<BxCustomerExploreResult>? topExplore;
  final String? errorMessage;
  BxSearchResult({
    this.agents,
    this.packages,
    this.topExplore,
    this.errorMessage,
  });
}

/// Holds the result of a cancel booking API call.
class BxCancelBookingResult {
  final bool success;
  final String? message;
  BxCancelBookingResult({required this.success, this.message});
}

// ── Implementation ────────────────────────────────────────────────────────────

/// Concrete implementation of [BxSystemRemoteDataSource] that uses
/// [BxDioClient] for HTTP communication.
class BxSystemRemoteDataSourceImpl implements BxSystemRemoteDataSource {
  final BxDioClient _dioClient;

  BxSystemRemoteDataSourceImpl({required BxDioClient dioClient})
    : _dioClient = dioClient;

  // ── Auth ────────────────────────────────────────────────────────────────────

  @override
  Future<BxFirebaseLoginResponse> loginUser(
    BxFirebaseLoginRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.post(
        BxApiEndpoints.loginUrl,
        options: options,
        data: request.toJson(),
      );
      if (response is Map<String, dynamic> && response['code'] == 0) {
        return BxFirebaseLoginResponse.fromJson(response);
      }
      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxFirebaseLoginResponse.fromJson(decoded);
          }
        } catch (_) {}
      }
      return BxFirebaseLoginResponse(
        code: 7,
        message: response['msg'],
        data: null,
      );
    } on BxNetworkException catch (e) {
      return BxFirebaseLoginResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxFirebaseLoginResponse(
        code: 7,
        message: 'login failed. Please try again.',
        data: null,
      );
    }
  }

  // ── Home ────────────────────────────────────────────────────────────────────

  @override
  Future<BxAdsResult> loadHomeAds() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.homeAdsUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxAdsResult(ads: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final ads =
          list
              ?.map((e) => BxAdBannerResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      return BxAdsResult(ads: ads);
    } on BxNetworkException catch (e) {
      return BxAdsResult(ads: [], errorMessage: e.message);
    } catch (e) {
      return BxAdsResult(ads: [], errorMessage: 'Failed to load ads.');
    }
  }

  @override
  Future<BxDestinationsResult> loadDestinations() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.homeDestinationsUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxDestinationsResult(destinations: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final destinations =
          list
              ?.map(
                (e) => BxCustomerDestinationCard.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [];
      return BxDestinationsResult(destinations: destinations);
    } on BxNetworkException catch (e) {
      return BxDestinationsResult(destinations: [], errorMessage: e.message);
    } catch (e) {
      return BxDestinationsResult(
        destinations: [],
        errorMessage: 'Failed to load destinations.',
      );
    }
  }

  @override
  Future<BxExploreTripsResult> loadExploreTrips(
    BxCustomerExploreRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final raw = await _dioClient.post(
        BxApiEndpoints.exploreTripsUrl,
        options: options,
        data: request.toJson(),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxExploreTripsResult(trips: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final trips =
          list
              ?.map(
                (e) =>
                    BxCustomerExploreResult.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [];
      return BxExploreTripsResult(trips: trips);
    } on BxNetworkException catch (e) {
      return BxExploreTripsResult(trips: [], errorMessage: e.message);
    } catch (e) {
      return BxExploreTripsResult(
        trips: [],
        errorMessage: 'Failed to load explore trips.',
      );
    }
  }

  @override
  Future<BxDealsResult> loadDeals(BxCustomerDealsRequest request) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final raw = await _dioClient.post(
        BxApiEndpoints.homeDealsUrl,
        options: options,
        data: request.toJson(),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxDealsResult(deals: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final deals =
          list
              ?.map(
                (e) => BxCustomerDealResult.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [];
      return BxDealsResult(deals: deals);
    } on BxNetworkException catch (e) {
      return BxDealsResult(deals: [], errorMessage: e.message);
    } catch (e) {
      return BxDealsResult(deals: [], errorMessage: 'Failed to load deals.');
    }
  }

  @override
  Future<BxAgentsResult> loadTopRatedAgents() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.homeAgentsUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxAgentsResult(agents: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final agents =
          list
              ?.map(
                (e) => BxCustomerAgentCard.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [];
      return BxAgentsResult(agents: agents);
    } on BxNetworkException catch (e) {
      return BxAgentsResult(agents: [], errorMessage: e.message);
    } catch (e) {
      return BxAgentsResult(agents: [], errorMessage: 'Failed to load agents.');
    }
  }

  @override
  Future<BxRecommendedResult> loadRecommended() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.homeRecommendedUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxRecommendedResult(packages: [], errorMessage: map['msg']);
      }
      final data = map['data'] as Map<String, dynamic>?;
      final list = data?['list'] as List<dynamic>?;
      final packages =
          list
              ?.map(
                (e) => BxCustomerRecommendedResult.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [];
      return BxRecommendedResult(packages: packages);
    } on BxNetworkException catch (e) {
      return BxRecommendedResult(packages: [], errorMessage: e.message);
    } catch (e) {
      return BxRecommendedResult(
        packages: [],
        errorMessage: 'Failed to load recommendations.',
      );
    }
  }

  @override
  Future<BxSearchResult> search(BxCustomerSearchRequest request) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final raw = await _dioClient.post(
        BxApiEndpoints.customerSearchUrl(
          request.keyword,
          page: request.page,
          pageSize: request.pageSize,
        ),
        options: options,
        data: request.toJson(),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxSearchResult(errorMessage: map['msg']);
      }
      final data = BxCustomerSearchData.fromJson(
        map['data'] as Map<String, dynamic>,
      );
      return BxSearchResult(
        agents: data.agents,
        packages: data.packages,
        topExplore: data.topExplore,
      );
    } on BxNetworkException catch (e) {
      return BxSearchResult(errorMessage: e.message);
    } catch (e) {
      return BxSearchResult(errorMessage: 'Search failed.');
    }
  }

  // ── Package Detail ──────────────────────────────────────────────────────────

  @override
  Future<BxPackageDetailResponse> loadPackageDetail(int packageId) async {
    try {
      final raw = await _dioClient.get(
        BxApiEndpoints.packageDetailUrl(packageId),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxPackageDetailResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxPackageDetailResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxPackageDetailResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxPackageDetailResponse(
        code: 7,
        message: 'Failed to load package detail.',
        data: null,
      );
    }
  }

  @override
  Future<BxPackageReviewsResponse> loadPackageReviews(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final raw = await _dioClient.get(
        BxApiEndpoints.packageReviewsUrl(
          packageId,
          page: page,
          pageSize: pageSize,
        ),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxPackageReviewsResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxPackageReviewsResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxPackageReviewsResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxPackageReviewsResponse(
        code: 7,
        message: 'Failed to load reviews.',
        data: null,
      );
    }
  }

  // ── Agent Detail ────────────────────────────────────────────────────────────

  @override
  Future<BxCustomerAgentDetailResponse> loadAgentDetail(
    BxCustomerAgentDetailRequest request,
  ) async {
    try {
      final raw = await _dioClient.get(
        BxApiEndpoints.agentDetailUrl(
          request.agentId,
          page: request.page,
          pageSize: request.pageSize,
        ),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxCustomerAgentDetailResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxCustomerAgentDetailResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxCustomerAgentDetailResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxCustomerAgentDetailResponse(
        code: 7,
        message: 'Failed to load agent detail.',
        data: null,
      );
    }
  }

  // ── Profile ─────────────────────────────────────────────────────────────────

  @override
  Future<BxProfileResponse> loadProfile() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.userProfileUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxProfileResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxProfileResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxProfileResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxProfileResponse(
        code: 7,
        message: 'Failed to load profile.',
        data: null,
      );
    }
  }

  // ── Booking ─────────────────────────────────────────────────────────────────

  @override
  Future<BxBookingListResponse> loadBookings() async {
    try {
      final raw = await _dioClient.get(BxApiEndpoints.bookingListUrl);
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxBookingListResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxBookingListResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxBookingListResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxBookingListResponse(
        code: 7,
        message: 'Failed to load bookings.',
        data: null,
      );
    }
  }

  @override
  Future<BxBookingDetailResponse> createBooking(
    BxCreateBookingRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final raw = await _dioClient.post(
        BxApiEndpoints.bookingListUrl,
        options: options,
        data: request.toJson(),
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxBookingDetailResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxBookingDetailResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxBookingDetailResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxBookingDetailResponse(
        code: 7,
        message: 'Failed to create booking.',
        data: null,
      );
    }
  }

  @override
  Future<BxBookingDetailResponse> loadBookingDetail(int bookingId) async {
    try {
      final raw = await _dioClient.get(
        '${BxApiEndpoints.bookingDetailUrl}?id=$bookingId',
      );
      final map = _decodeResponse(raw);
      if (map['code'] != 0) {
        return BxBookingDetailResponse(
          code: map['code'],
          message: map['msg'],
          data: null,
        );
      }
      return BxBookingDetailResponse.fromJson(map);
    } on BxNetworkException catch (e) {
      return BxBookingDetailResponse(
        code: e.statusCode,
        message: e.message,
        data: null,
      );
    } catch (e) {
      return BxBookingDetailResponse(
        code: 7,
        message: 'Failed to load booking detail.',
        data: null,
      );
    }
  }

  @override
  Future<BxCancelBookingResult> cancelBooking(
    BxCancelBookingRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final raw = await _dioClient.post(
        BxApiEndpoints.cancelBookingUrl,
        options: options,
        data: request.toJson(),
      );
      final map = _decodeResponse(raw);
      if (map['code'] == 0) {
        return BxCancelBookingResult(success: true);
      }
      return BxCancelBookingResult(success: false, message: map['msg']);
    } on BxNetworkException catch (e) {
      return BxCancelBookingResult(success: false, message: e.message);
    } catch (e) {
      return BxCancelBookingResult(
        success: false,
        message: 'Failed to cancel booking.',
      );
    }
  }
}
