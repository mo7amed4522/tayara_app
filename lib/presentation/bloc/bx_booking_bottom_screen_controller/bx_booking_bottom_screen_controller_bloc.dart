// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Booking Bottom Screen Controller
// Purpose: BLoC for managing booking bottom screen state and tab filtering
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_booking_bottom_screen_controller_state.dart';
part 'bx_booking_bottom_screen_controller_event.dart';

class BxBookingBottomScreenControllerBloc
    extends Bloc<BxBookingBottomScreenControllerEvent, BxBookingBottomScreenControllerState> {
  BxBookingBottomScreenControllerBloc()
      : super(
          const BxBookingBottomScreenControllerState(
            status: BxBookingBottomScreenControllerStatus.initial,
          ),
        ) {
    on<BxLoadBookings>(_onLoadBookings);
    on<BxFilterBookings>(_onFilterBookings);
  }

  void _onLoadBookings(
    BxLoadBookings event,
    Emitter<BxBookingBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(status: BxBookingBottomScreenControllerStatus.loading));
    try {
      final bookings = [
        {
          'image': 'assets/images/recommend_image1.png',
          'name': 'Bali Paradise 5D/4N',
          'date': '15 Jan 2026',
          'status': 'confirmed',
          'price': '\$1,250',
        },
        {
          'image': 'assets/images/recommend_image2.png',
          'name': 'Paris Romance 4D/3N',
          'date': '22 Feb 2026',
          'status': 'pending',
          'price': '\$1,100',
        },
        {
          'image': 'assets/images/recommend_image1.png',
          'name': 'Tokyo Discovery 6D/5N',
          'date': '10 Mar 2026',
          'status': 'expired',
          'price': '\$1,450',
        },
      ];
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
