/// Concrete implementation of [BxGetMyBookingListRepositories] that fetches
/// the current user's booking list through the remote data source.
///
/// This implementation handles [BxNetworkException] explicitly by converting
/// it into a [BxGetMyBookingListResponse] with an error status, rather than
/// letting the exception propagate. This ensures that callers always receive
/// a response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_my_booking_list_request.dart';
import 'package:tayara/domain/model/response/bx_get_my_booking_list_response.dart';
import 'package:tayara/domain/repositories/bx_get_my_booking_list_repositories.dart';

// File: lib/data/repositories/bx_get_my_booking_list_repositories_impl.dart
// Architecture: Data Layer - Bx Get My Booking List Repository Implementation
// Purpose: Provides concrete implementation of the get my booking list interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetMyBookingListRepositoriesImpl
    implements BxGetMyBookingListRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetMyBookingListRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches the current user's booking list by calling the remote endpoint.
  ///
  /// On success a [BxGetMyBookingListResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 500 error response.
  @override
  Future<BxGetMyBookingListResponse> fetchMyBookingList(
    BxGetMyBookingListRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchMyBookingList(
        request,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxGetMyBookingListResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetMyBookingListResponse(
        code: 500,
        msg: 'Failed to fetch booking list. Please try again.',
        data: null,
      );
    }
  }
}
