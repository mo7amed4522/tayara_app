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
  final BxLoginUserResponse? firebaseUser;

  const BxProfileBottomScreenControllerState({
    required this.status,
    this.errorMessage,
    this.isDarkMode = false,
    this.firebaseUser,
  });

  BxProfileBottomScreenControllerState copyWith({
    BxProfileBottomScreenControllerStatus? status,
    String? errorMessage,
    bool? isDarkMode,
    BxLoginUserResponse? firebaseUser,
  }) {
    return BxProfileBottomScreenControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      firebaseUser: firebaseUser ?? this.firebaseUser,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, isDarkMode, firebaseUser];
}
