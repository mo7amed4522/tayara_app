// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Booking Bottom Screen Controller
// Purpose: BLoC for managing booking bottom screen state and tab filtering
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/domain/usecase/bx_booking_usecase.dart';

part 'bx_booking_bottom_screen_controller_state.dart';
part 'bx_booking_bottom_screen_controller_event.dart';

class BxBookingBottomScreenControllerBloc
    extends
        Bloc<
          BxBookingBottomScreenControllerEvent,
          BxBookingBottomScreenControllerState
        > {
  final BxBookingUsecase _bookingUsecase;

  BxBookingBottomScreenControllerBloc({
    required BxBookingUsecase bookingUsecase,
  }) : _bookingUsecase = bookingUsecase,
       super(
         const BxBookingBottomScreenControllerState(
           status: BxBookingBottomScreenControllerStatus.initial,
         ),
       ) {
    on<BxLoadBookings>(_onLoadBookings);
    on<BxFilterBookings>(_onFilterBookings);
  }

  Future<void> _onLoadBookings(
    BxLoadBookings event,
    Emitter<BxBookingBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxBookingBottomScreenControllerStatus.loading));
    try {
      final result = await _bookingUsecase.loadBookings();
      final bookings = (result.data?.list ?? []).map((booking) {
        return <String, String>{
          'image': BxAppConstant.recommendImage1,
          'name': 'Booking #${booking.id ?? booking.bookingCode ?? ''}',
          'date': booking.startDate ?? booking.requestedAt ?? '',
          'status': booking.bookingStatus ?? 'pending',
          'price': booking.amountGross != null
              ? '\$${booking.amountGross}'
              : '\$0',
        };
      }).toList();
      emit(
        state.copyWith(
          status: BxBookingBottomScreenControllerStatus.success,
          bookings: bookings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BxBookingBottomScreenControllerStatus.failure),
      );
    }
  }

  void _onFilterBookings(
    BxFilterBookings event,
    Emitter<BxBookingBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }
}
