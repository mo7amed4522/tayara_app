// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/data/data_sources/remote/bx_system_remote_data_source.dart
// Architecture: Core -> Data -> Data Sources -> Remote -> Bx System Remote Data Source - Error Handler
// Purpose: Centralized error handling and logging for system-related remote data source operations

// ignore_for_file: prefer_initializing_formals, unused_field

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tayara/core/network/bx_api_endpoints.dart';
import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/domain/model/request/bx_firebase_login_request.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';

/// Defines the contract for remote API calls related to the core system
/// functionalities: authentication, services, reservations, doctors,
/// specialties, FAQs, reviews, leads, and push token registration.
///
/// Every method returns a response object *without throwing exceptions*;
/// network and server errors are captured inside the response model's
/// status/code fields, allowing callers to handle errors uniformly.
abstract class BxSystemRemoteDataSource {
  /// Logs in the user with the provided credentials.
  ///
  /// Returns a [BxFirebaseLoginResponse] indicating success or failure.
  Future<BxFirebaseLoginResponse> loginUser(BxFirebaseLoginRequest request);
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
        } catch (_) {
          // Fall through to return failure below.
        }
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
}
