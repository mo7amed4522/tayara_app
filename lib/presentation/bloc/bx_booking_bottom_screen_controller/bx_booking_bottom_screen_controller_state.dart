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
  // Updated to hold the actual list of booking items
  final List<BxMyBookingItem> bookings;
  final int selectedTab;
  final BxPaginationResponse? pagination;

  const BxBookingBottomScreenControllerState({
    required this.status,
    this.errorMessage,
    this.bookings = const [],
    this.selectedTab = 0,
    this.pagination,
  });

  BxBookingBottomScreenControllerState copyWith({
    BxBookingBottomScreenControllerStatus? status,
    String? errorMessage,
    List<BxMyBookingItem>? bookings,
    bool clearBookings = false,
    int? selectedTab,
    BxPaginationResponse? pagination,
  }) {
    return BxBookingBottomScreenControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bookings: clearBookings ? [] : (bookings ?? this.bookings),
      selectedTab: selectedTab ?? this.selectedTab,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    bookings,
    selectedTab,
    pagination,
  ];
}
