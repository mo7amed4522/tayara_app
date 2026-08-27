// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_booking_usecase.dart
// Architecture: Domain Layer - Booking UseCase
// Purpose: Defines the booking use cases

import 'package:tayara/domain/model/request/bx_booking_request.dart';
import 'package:tayara/domain/model/response/bx_booking_response.dart';
import 'package:tayara/domain/repositories/bx_booking_repositories.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';

class BxBookingUsecase {
  final BxBookingRepositories _repositories;

  BxBookingUsecase(this._repositories);

  Future<BxBookingListResponse> loadBookings() => _repositories.loadBookings();
  Future<BxBookingDetailResponse> createBooking(
    BxCreateBookingRequest request,
  ) => _repositories.createBooking(request);
  Future<BxBookingDetailResponse> loadBookingDetail(int bookingId) =>
      _repositories.loadBookingDetail(bookingId);
  Future<BxCancelBookingResult> cancelBooking(BxCancelBookingRequest request) =>
      _repositories.cancelBooking(request);
}
