// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_my_booking_list_repositories.dart
// Architecture: Domain Layer - Bx Get My Booking List Repository
// Purpose: Define the get my booking list repository for the application

import 'package:tayara/domain/model/request/bx_get_my_booking_list_request.dart';
import 'package:tayara/domain/model/response/bx_get_my_booking_list_response.dart';

///
/// Implementations call the remote booking list endpoint using the user's
/// credentials and return the outcome.
abstract class BxGetMyBookingListRepositories {
  /// Fetches the current user's booking list with the provided request.
  ///
  /// Returns a [BxGetMyBookingListResponse] indicating success or failure.
  Future<BxGetMyBookingListResponse> fetchMyBookingList(
    BxGetMyBookingListRequest request,
  );
}
