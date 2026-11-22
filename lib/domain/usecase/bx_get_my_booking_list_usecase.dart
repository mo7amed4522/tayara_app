// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_my_booking_list_usecase.dart
// Architecture: Domain Layer - Bx Get My Booking List UseCase
// Purpose: Defines the get my booking list use case

import 'package:tayara/domain/model/request/bx_get_my_booking_list_request.dart';
import 'package:tayara/domain/model/response/bx_get_my_booking_list_response.dart';
import 'package:tayara/domain/repositories/bx_get_my_booking_list_repositories.dart';

/// Use case that fetches the current user's booking list with the provided
/// request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetMyBookingListResponse] indicating success or failure.
class BxGetMyBookingListUsecase {
  final BxGetMyBookingListRepositories repositories;

  /// Creates a [BxGetMyBookingListUsecase] with the necessary [repositories].
  BxGetMyBookingListUsecase(this.repositories);

  /// Fetches the current user's booking list with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetMyBookingListResponse> execute(
    BxGetMyBookingListRequest request,
  ) {
    return repositories.fetchMyBookingList(request);
  }
}
