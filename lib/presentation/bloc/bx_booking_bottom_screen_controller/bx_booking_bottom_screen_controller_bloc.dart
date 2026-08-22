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
    extends
        Bloc<
          BxBookingBottomScreenControllerEvent,
          BxBookingBottomScreenControllerState
        > {
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
      final List<Map<String, String?>> bookings = [
        {
          'image': 'assets/images/recommend_image1.png',
          'name': 'Cairo Explorer',
          'days': '5 Days',
          'date': 'March 15 - 20, 2025',
          'agency': 'Travel Vista Tours',
          'agencyRating': '4.8',
          'priceLabel': 'Estimated Price Range',
          'price': r'$800 - $1,200',
          'status': 'pending',
          'timeLeft': '18h left',
          'expiredDate': null,
        },
        {
          'image': 'assets/images/recommend_image2.png',
          'name': 'Paris Romance',
          'days': '4 Days',
          'date': 'April 10 - 14, 2025',
          'agency': 'Luxury Getaways',
          'agencyRating': '4.5',
          'priceLabel': 'Estimated Price Range',
          'price': r'$1,100 - $1,500',
          'status': 'pending',
          'timeLeft': '6h left',
          'expiredDate': null,
        },
        {
          'image': 'assets/images/recommend_image1.png',
          'name': 'Cairo Explorer',
          'days': '5 Days',
          'date': 'March 15 - 20, 2025',
          'agency': 'Travel Vista Tours',
          'agencyRating': '4.8',
          'priceLabel': 'Final Price',
          'price': r'$950',
          'status': 'confirmed',
          'timeLeft': null,
          'expiredDate': null,
        },
        {
          'image': 'assets/images/recommend_image2.png',
          'name': 'Tokyo Discovery',
          'days': '6 Days',
          'date': 'May 1 - 7, 2025',
          'agency': 'Asia Travels Co.',
          'agencyRating': '4.2',
          'priceLabel': 'Estimated Price Range',
          'price': r'$1,450 - $1,800',
          'status': 'expired',
          'timeLeft': null,
          'expiredDate': 'Mar 22, 2025',
        },
        {
          'image': 'assets/images/recommend_image1.png',
          'name': 'Bali Paradise',
          'days': '5 Days',
          'date': 'June 10 - 15, 2025',
          'agency': 'Island Escapes',
          'agencyRating': '4.9',
          'priceLabel': 'Estimated Price Range',
          'price': r'$1,200 - $1,600',
          'status': 'expired',
          'timeLeft': null,
          'expiredDate': 'Apr 5, 2025',
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
