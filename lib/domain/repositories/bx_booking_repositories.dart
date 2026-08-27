// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_booking_repositories.dart
// Architecture: Domain Layer - Booking Repository
// Purpose: Define the booking repository interface for the application

import 'package:tayara/domain/model/request/bx_booking_request.dart';
import 'package:tayara/domain/model/response/bx_booking_response.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';

abstract class BxBookingRepositories {
  Future<BxBookingListResponse> loadBookings();
  Future<BxBookingDetailResponse> createBooking(BxCreateBookingRequest request);
  Future<BxBookingDetailResponse> loadBookingDetail(int bookingId);
  Future<BxCancelBookingResult> cancelBooking(BxCancelBookingRequest request);
}
