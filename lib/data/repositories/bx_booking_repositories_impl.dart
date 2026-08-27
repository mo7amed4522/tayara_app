// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_booking_repositories_impl.dart
// Architecture: Data Layer - Booking Repository Implementation
// Purpose: Provides concrete implementation of the booking repository interface

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_booking_request.dart';
import 'package:tayara/domain/model/response/bx_booking_response.dart';
import 'package:tayara/domain/repositories/bx_booking_repositories.dart';

class BxBookingRepositoriesImpl implements BxBookingRepositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  BxBookingRepositoriesImpl({
    required BxSystemRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<BxBookingListResponse> loadBookings() =>
      _remoteDataSource.loadBookings();

  @override
  Future<BxBookingDetailResponse> createBooking(
    BxCreateBookingRequest request,
  ) => _remoteDataSource.createBooking(request);

  @override
  Future<BxBookingDetailResponse> loadBookingDetail(int bookingId) =>
      _remoteDataSource.loadBookingDetail(bookingId);

  @override
  Future<BxCancelBookingResult> cancelBooking(BxCancelBookingRequest request) =>
      _remoteDataSource.cancelBooking(request);
}
