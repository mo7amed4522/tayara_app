// File: lib/core/data/data_sources/remote/bx_system_remote_data_source.dart
// Architecture: Core -> Data -> Data Sources -> Remote -> Bx System Remote Data Source - Error Handler
// Purpose: Centralized error handling and logging for system-related remote data source operations

// ignore_for_file: use_build_context_synchronously, prefer_initializing_formals, unused_field

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/network/bx_api_endpoints.dart';
import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/request/bx_agent_profile_details_request.dart';
import 'package:tayara/domain/model/request/bx_custom_search_request.dart';
import 'package:tayara/domain/model/request/bx_get_destinations_request.dart';
import 'package:tayara/domain/model/request/bx_get_explore_topic_request.dart';
import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/request/bx_get_recommended_for_customer_request.dart';
import 'package:tayara/domain/model/request/bx_get_search_request.dart';
import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/request/bx_get_top_deals_request.dart';
import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_topic_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_deals_response.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';

/// Defines the contract for remote API calls related to the core system
/// functionalities: authentication, services, reservations, doctors,
/// specialties, FAQs, reviews, leads, and push token registration.
///
/// Every method returns a response object *without throwing exceptions*;
/// network and server errors are captured inside the response model's
/// status/code fields, allowing callers to handle errors uniformly.
abstract class BxSystemRemoteDataSource {
  /// Logs in the user with the provided credentials.
  Future<BxLoginUserResponse> loginUserFire(BxLoginUserRequest request);

  /// Fetches the login user with the provided request.
  ///
  /// Returns a [BxLoginUserResponse] indicating success or failure.
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request);

  /// Fetches the active top banner ads with the provided request.
  ///
  /// Returns a [BxActiveTopBannerAdsResponse] indicating success or failure.
  Future<BxActiveTopBannerAdsResponse> fetchActiveTopBannerAds(
    BxActiveTopBannerAdsRequest request,
  );

  /// Fetches the destinations with the provided request.
  ///
  /// Returns a [BxGetDestinationsResponse] indicating success or failure.
  Future<BxGetDestinationsResponse> fetchDestinations(
    BxGetDestinationsRequest request,
  );

  /// Fetches the explore trips with the provided request.
  ///
  /// Returns a [BxGetExploreTripsResponse] indicating success or failure.
  Future<BxGetExploreTripsResponse> fetchExploreTrips(
    BxGetExploreTripsRequest request,
  );

  /// Fetches the top deals with the provided request.
  ///
  /// Returns a [BxGetTopDealsResponse] indicating success or failure.
  Future<BxGetTopDealsResponse> fetchTopDeals(BxGetTopDealsRequest request);

  /// Fetches the top agents with the provided request.
  ///
  /// Returns a [BxGetTopAgentsResponse] indicating success or failure.
  Future<BxGetTopAgentResponse> fetchTopAgents(BxGetTopAgentRequest request);

  /// Fetches the search results with the provided request.
  ///
  /// Returns a [BxGetSearchResponse] indicating success or failure.
  Future<BxGetSearchResponse> fetchSearchResults(BxGetSearchRequest request);

  /// Fetches the recommended packages for the customer with the provided request.
  ///
  /// Returns a [BxGetRecommendedForCustomerResponse] indicating success or failure.
  Future<BxGetRecommendedForCustomerResponse> fetchRecommendedForCustomer(
    BxGetRecommendedForCustomerRequest request,
  );

  /// Fetches the search that user want with the provided request.
  ///
  /// Returns a [BxCustomSearchResponse] indicating success or failure.
  Future<BxCustomSearchResponse> fetchCustomSearch(
    BxCustomSearchRequest request,
  );

  /// Fetches the Agent profile details with the provided request.
  ///
  /// Returns a [BxAgentProfileDetailsResponse] indicating success or failure.
  Future<BxAgentProfileDetailsResponse> fetchAgentDetailsData(
    BxAgentProfileDetailsRequest request,
  );

  /// Fetches the explore topic with the provided request.
  ///
  /// Returns a [BxGetExploreTopicResponse] indicating success or failure.
  Future<BxGetExploreTopicResponse> fetchExploreTopic(
    BxGetExploreTopicRequest request,
  );
}

/// Concrete implementation of [BxSystemRemoteDataSource] that uses
/// [BxDioClient] for HTTP communication.
///
/// Each method follows a consistent error‑handling pattern:
/// - On a successful 200 response the corresponding success model is
///   returned (populated from JSON).
/// - If the raw response is a [String], it attempts to decode it as JSON.
/// - If a [BxNetworkException] occurs, an error response model with the
///   exception's status code and message is returned.
/// - Any other exception is caught and translated into a generic error
///   response model with a 500 status code.
///
/// This design ensures that callers never receive uncaught exceptions and
/// can inspect the response object's `status` or `code` to determine
/// success or failure.
class BxSystemRemoteDataSourceImpl implements BxSystemRemoteDataSource {
  final BxDioClient _dioClient;

  BxSystemRemoteDataSourceImpl({required BxDioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<BxLoginUserResponse> loginUserFire(BxLoginUserRequest request) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.post(
        BxApiEndpoints.loginUrl,
        options: options,
        data: request.toJson(),
      );
      if (response is Map<String, dynamic> && response['code'] == 0) {
        return BxLoginUserResponse.fromJson(response);
      }
      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxLoginUserResponse.fromJson(decoded);
          }
        } catch (_) {}
      }
      return BxLoginUserResponse(code: 7, msg: response['msg'], data: null);
    } on BxNetworkException catch (e) {
      return BxLoginUserResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxLoginUserResponse(
        code: 7,
        msg: 'login failed. Please try again.',
        data: null,
      );
    }
  }

  @override
  Future<BxActiveTopBannerAdsResponse> fetchActiveTopBannerAds(
    BxActiveTopBannerAdsRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeAdsUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxActiveTopBannerAdsResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxActiveTopBannerAdsResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxActiveTopBannerAdsResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching active top banner ads.',
      );
    } on BxNetworkException catch (e) {
      return BxActiveTopBannerAdsResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxActiveTopBannerAdsResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching active top banner ads.',
      );
    }
  }

  @override
  Future<BxGetDestinationsResponse> fetchDestinations(
    BxGetDestinationsRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeDestinationsUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxGetDestinationsResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetDestinationsResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetDestinationsResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching active top banner ads.',
      );
    } on BxNetworkException catch (e) {
      return BxGetDestinationsResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetDestinationsResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching active top banner ads.',
      );
    }
  }

  @override
  Future<BxGetExploreTripsResponse> fetchExploreTrips(
    BxGetExploreTripsRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeExploreTripsUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxGetExploreTripsResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetExploreTripsResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetExploreTripsResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching active top banner ads.',
      );
    } on BxNetworkException catch (e) {
      return BxGetExploreTripsResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetExploreTripsResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching active top banner ads.',
      );
    }
  }

  @override
  Future<BxGetTopDealsResponse> fetchTopDeals(
    BxGetTopDealsRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeTopDealsUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxGetTopDealsResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetTopDealsResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetTopDealsResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching active top banner ads.',
      );
    } on BxNetworkException catch (e) {
      return BxGetTopDealsResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetTopDealsResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching active top banner ads.',
      );
    }
  }

  @override
  Future<BxGetTopAgentResponse> fetchTopAgents(
    BxGetTopAgentRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeTopAgentsUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxGetTopAgentResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetTopAgentResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetTopAgentResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching active top banner ads.',
      );
    } on BxNetworkException catch (e) {
      return BxGetTopAgentResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetTopAgentResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching active top banner ads.',
      );
    }
  }

  @override
  Future<BxGetSearchResponse> fetchSearchResults(
    BxGetSearchRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.get(
        BxApiEndpoints.homeSearchUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxGetSearchResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetSearchResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetSearchResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ?? 'Unknown error occurred while fetching search .',
      );
    } on BxNetworkException catch (e) {
      return BxGetSearchResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetSearchResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching search .',
      );
    }
  }

  @override
  Future<BxLoginUserResponse> loginUser(BxLoginUserRequest request) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.post(
        BxApiEndpoints.loginCustomerUrl,
        options: options,
        data: request.toJson(),
      );
      if (response['code'] == 0) {
        return BxLoginUserResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxLoginUserResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxLoginUserResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching user data .',
      );
    } on BxNetworkException catch (e) {
      return BxLoginUserResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxLoginUserResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching user data .',
      );
    }
  }

  @override
  Future<BxGetRecommendedForCustomerResponse> fetchRecommendedForCustomer(
    BxGetRecommendedForCustomerRequest request,
  ) async {
    try {
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'X-token': BxAppData.currentUser?.data?.token,
        },
      );
      final response = await _dioClient.get(
        BxApiEndpoints.homeRecommendationUrl,
        options: options,
        queryParameters: request.toJson(),
      );
      if (response is Map<String, dynamic> && response['code'] == 0) {
        return BxGetRecommendedForCustomerResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetRecommendedForCustomerResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      // Non-zero code (e.g. 1001 unauthorized) or malformed response.
      // Preserve the actual code from the API so callers can branch on it.
      final int code = (response is Map<String, dynamic>)
          ? (response['code'] as int?) ?? 1
          : 1;
      final String? msg =
          (response is Map<String, dynamic> && response['msg'] != null)
          ? response['msg'] as String?
          : null;
      return BxGetRecommendedForCustomerResponse(
        code: code,
        data: null,
        msg: msg ?? 'Unknown error occurred while fetching recommended items .',
      );
    } on BxNetworkException catch (e) {
      return BxGetRecommendedForCustomerResponse(
        code: 1,
        data: null,
        msg: e.message,
      );
    } catch (e) {
      return BxGetRecommendedForCustomerResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching recommended items .',
      );
    }
  }

  @override
  Future<BxCustomSearchResponse> fetchCustomSearch(
    BxCustomSearchRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final queryPramter = {
        'keyword': request.keyword,
        'page': request.page,
        'pageSize': request.pageSize,
      };
      final response = await _dioClient.get(
        BxApiEndpoints.customSearchUrl,
        options: options,
        queryParameters: queryPramter,
      );
      if (response['code'] == 0) {
        return BxCustomSearchResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxCustomSearchResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxCustomSearchResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching user data .',
      );
    } on BxNetworkException catch (e) {
      return BxCustomSearchResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxCustomSearchResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching user data .',
      );
    }
  }

  @override
  Future<BxAgentProfileDetailsResponse> fetchAgentDetailsData(
    BxAgentProfileDetailsRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final queryPramter = {
        'agentId': request.agentId,
        'page': request.page,
        'pageSize': request.pageSize,
      };
      final response = await _dioClient.get(
        BxApiEndpoints.agentProfileUrl,
        options: options,
        queryParameters: queryPramter,
      );
      if (response['code'] == 0) {
        return BxAgentProfileDetailsResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxAgentProfileDetailsResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxAgentProfileDetailsResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching agent detail data .',
      );
    } on BxNetworkException catch (e) {
      return BxAgentProfileDetailsResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxAgentProfileDetailsResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching agent detail data .',
      );
    }
  }

  @override
  Future<BxGetExploreTopicResponse> fetchExploreTopic(
    BxGetExploreTopicRequest request,
  ) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final queryPramter = {'page': request.page, 'pageSize': request.pageSize};
      final response = await _dioClient.get(
        BxApiEndpoints.exploreTopic,
        options: options,
        queryParameters: queryPramter,
      );
      if (response['code'] == 0) {
        return BxGetExploreTopicResponse.fromJson(response);
      }

      if (response is String) {
        try {
          final decoded = jsonDecode(response);
          if (decoded is Map<String, dynamic>) {
            return BxGetExploreTopicResponse.fromJson(decoded);
          }
        } catch (_) {
          // Fall through to return failure below.
        }
      }

      return BxGetExploreTopicResponse(
        code: 1,
        data: null,
        msg:
            response['msg'] ??
            'Unknown error occurred while fetching explore topic data .',
      );
    } on BxNetworkException catch (e) {
      return BxGetExploreTopicResponse(code: 1, data: null, msg: e.message);
    } catch (e) {
      return BxGetExploreTopicResponse(
        code: 2,
        data: null,
        msg: 'Unknown error occurred while fetching explore topic data .',
      );
    }
  }
}
