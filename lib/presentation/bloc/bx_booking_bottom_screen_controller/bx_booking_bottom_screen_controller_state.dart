// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Bx Booking Bottom Screen Controller
// Purpose: State management for the booking bottom screen
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously

part of 'bx_booking_bottom_screen_controller_bloc.dart';

enum BxBookingBottomScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxBookingBottomScreenControllerState extends Equatable {
  final BxBookingBottomScreenControllerStatus status;
  final String? errorMessage;

  const BxBookingBottomScreenControllerState({
    required this.status,
    this.errorMessage,
  });

  BxBookingBottomScreenControllerState copyWith({
    BxBookingBottomScreenControllerStatus? status,
    String? errorMessage,
  }) {
    return BxBookingBottomScreenControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
