// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_state.dart
// Architecture: Presentation Layer - Bx Splash Screen Controller
// Purpose: BLoC for managing splash screen state and persistence

// ignore_for_file: must_be_immutable

part of 'bx_splash_screen_controller_bloc.dart';

enum BxSplashScreenStatus { initial, loading, success, error }

class BxSplashScreenControllerState extends Equatable {
  final BxSplashScreenStatus status;
  final bool onBoardingCompleted;
  final String? errorMessage;

  const BxSplashScreenControllerState({
    this.status = BxSplashScreenStatus.initial,
    this.onBoardingCompleted = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage, onBoardingCompleted];

  BxSplashScreenControllerState copyWith({
    BxSplashScreenStatus? status,
    bool? onBoardingCompleted,
    String? errorMessage,
  }) {
    return BxSplashScreenControllerState(
      status: status ?? this.status,
      onBoardingCompleted: onBoardingCompleted ?? this.onBoardingCompleted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
