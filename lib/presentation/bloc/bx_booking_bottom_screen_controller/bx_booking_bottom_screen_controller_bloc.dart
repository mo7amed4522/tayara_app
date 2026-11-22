// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Booking Bottom Screen Controller
// Purpose: BLoC for managing booking bottom screen state and tab filtering
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/utils/bx_pagination_response.dart';
import 'package:tayara/domain/model/request/bx_get_my_booking_list_request.dart';
import 'package:tayara/domain/model/response/bx_get_my_booking_list_response.dart';
import 'package:tayara/domain/usecase/bx_get_my_booking_list_usecase.dart';

part 'bx_booking_bottom_screen_controller_state.dart';
part 'bx_booking_bottom_screen_controller_event.dart';

class BxBookingBottomScreenControllerBloc
    extends
        Bloc<
          BxBookingBottomScreenControllerEvent,
          BxBookingBottomScreenControllerState
        > {
  final BxGetMyBookingListUsecase _getMyBookingListUsecase;
  static const int pageSize = 10;

  BxBookingBottomScreenControllerBloc({
    required BxGetMyBookingListUsecase getMyBookingListUsecase,
  }) : _getMyBookingListUsecase = getMyBookingListUsecase,
       super(
         const BxBookingBottomScreenControllerState(
           status: BxBookingBottomScreenControllerStatus.initial,
         ),
       ) {
    on<BxLoadBookings>(_onLoadBookings);
    on<BxFilterBookings>(_onFilterBookings);
  }

  // Maps tab index to status filter strings
  // 0: Active (Processing, Booked, etc.)
  // 1: Completed
  // 2: Cancelled
  static const _tabStatusMap = {
    0: [
      'requested',
      'agent_reviewing',
      'price_confirmed',
      'awaiting_payment',
      'payment_authorized',
      'paid_confirmed',
      'docs_pending',
      'docs_submitted',
      'kyc_pending',
      'kyc_approved',
      'docs_pending_correction',
      'booking_confirmed',
      'processing',
      'issued_ready',
    ],
    1: ['completed'],
    2: ['cancelled', 'refunded', 'price_expired'],
  };

  Future<void> _onLoadBookings(
    BxLoadBookings event,
    Emitter<BxBookingBottomScreenControllerState> emit,
  ) async {
    // Prevent load if already loading or no more pages
    if (state.status == BxBookingBottomScreenControllerStatus.loading) return;
    if (state.pagination != null &&
        state.pagination!.isComplete &&
        !event.isRefresh) {
      return;
    }

    final isRefresh = event.isRefresh;
    final nextPage = isRefresh ? 1 : (state.pagination?.page ?? 0) + 1;

    if (isRefresh) {
      emit(
        state.copyWith(
          status: BxBookingBottomScreenControllerStatus.loading,
          bookings: [],
        ),
      );
    } else {
      emit(
        state.copyWith(status: BxBookingBottomScreenControllerStatus.loading),
      );
    }

    try {
      final statuses = _tabStatusMap[state.selectedTab] ?? [];
      // Pass the first status as the filter for now, or adapt as the API expects
      final request = BxGetMyBookingListRequest(
        page: nextPage,
        pageSize: pageSize,
        status: statuses.isNotEmpty ? statuses.first : null,
      );

      final response = await _getMyBookingListUsecase.execute(request);

      if (response.code == 0 && response.data != null) {
        final data = response.data!;
        final newBookings = isRefresh
            ? data.list
            : [...state.bookings, ...data.list];
        final pagination = BxPaginationResponse(
          page: data.page,
          limit: data.pageSize,
          total: data.total,
          pages: data.totalPage,
        );

        emit(
          state.copyWith(
            status: BxBookingBottomScreenControllerStatus.success,
            bookings: newBookings,
            pagination: pagination,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxBookingBottomScreenControllerStatus.failure,
            errorMessage: response.msg,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxBookingBottomScreenControllerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFilterBookings(
    BxFilterBookings event,
    Emitter<BxBookingBottomScreenControllerState> emit,
  ) {
    emit(
      state.copyWith(
        selectedTab: event.tabIndex,
        bookings: [],
        clearBookings: true,
        pagination: null,
      ),
    );
    add(const BxLoadBookings(isRefresh: true));
  }
}
