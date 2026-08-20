// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_event.dart
// Architecture: Presentation Layer - Booking Bottom Screen Controller
// Purpose: Events for booking bottom screen BLoC

part of 'bx_booking_bottom_screen_controller_bloc.dart';

abstract class BxBookingBottomScreenControllerEvent extends Equatable {
  const BxBookingBottomScreenControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxLoadBookings extends BxBookingBottomScreenControllerEvent {
  const BxLoadBookings();
}

class BxFilterBookings extends BxBookingBottomScreenControllerEvent {
  final int tabIndex;
  const BxFilterBookings({required this.tabIndex});
  @override
  List<Object?> get props => [tabIndex];
}
