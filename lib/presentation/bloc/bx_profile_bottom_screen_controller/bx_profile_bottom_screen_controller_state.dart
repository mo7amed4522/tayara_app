// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Profile Bottom Screen Controller
// Purpose: State management for the profile bottom screen
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously

part of 'bx_profile_bottom_screen_controller_bloc.dart';

enum BxProfileBottomScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxProfileBottomScreenControllerState extends Equatable {
  final BxProfileBottomScreenControllerStatus status;
  final String? errorMessage;
  final bool isDarkMode;
  final bool isNotificationsEnabled;

  /// The current user's profile returned by `GET /api/v1/user/profile`.
  final BxGetUserDataUser? user;

  /// Counters returned alongside the profile.
  final int pastTrips;
  final int upcoming;
  final int favorites;

  /// True while a `DELETE /api/v1/user/account` request is in-flight.
  final bool isDeleting;

  /// Set to true once the account deletion succeeded; UI should log out + route.
  final bool isAccountDeleted;

  const BxProfileBottomScreenControllerState({
    required this.status,
    this.errorMessage,
    this.isDarkMode = false,
    this.isNotificationsEnabled = true,
    this.user,
    this.pastTrips = 0,
    this.upcoming = 0,
    this.favorites = 0,
    this.isDeleting = false,
    this.isAccountDeleted = false,
  });

  BxProfileBottomScreenControllerState copyWith({
    BxProfileBottomScreenControllerStatus? status,
    String? errorMessage,
    bool? isDarkMode,
    bool? isNotificationsEnabled,
    BxGetUserDataUser? user,
    int? pastTrips,
    int? upcoming,
    int? favorites,
    bool? isDeleting,
    bool? isAccountDeleted,
  }) {
    return BxProfileBottomScreenControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      user: user ?? this.user,
      pastTrips: pastTrips ?? this.pastTrips,
      upcoming: upcoming ?? this.upcoming,
      favorites: favorites ?? this.favorites,
      isDeleting: isDeleting ?? this.isDeleting,
      isAccountDeleted: isAccountDeleted ?? this.isAccountDeleted,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    isDarkMode,
    isNotificationsEnabled,
    user,
    pastTrips,
    upcoming,
    favorites,
    isDeleting,
    isAccountDeleted,
  ];
}
