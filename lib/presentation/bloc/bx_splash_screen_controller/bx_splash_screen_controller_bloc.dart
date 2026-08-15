// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart
// Architecture: Presentation Layer - Splash Screen Controller
// Purpose: BLoC for managing splash screen state and persistence
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously

import 'package:tayara/core/constant/bx_shared_preferences_keys.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_splash_screen_controller_state.dart';
part 'bx_splash_screen_controller_event.dart';

class BxSplashScreenControllerBloc extends Bloc<BxSplashScreenControllerEvent, BxSplashScreenControllerState> {
  final BxSharedPreferencesDataSource _sharedPreferencesDataSource;

  BxSplashScreenControllerBloc({required BxSharedPreferencesDataSource sharedPreferencesDataSource}) : _sharedPreferencesDataSource = sharedPreferencesDataSource, super(BxSplashScreenControllerState()) {
    on<BxStartSplashTimer>(_onStartSplashTimer);
    on<BxResetSplashScreen>(_onResetSplashScreen);
    on<BxCheckAndStartSplash>(_onCheckAndStartSplash);
  }

  Future<void> _onStartSplashTimer(BxStartSplashTimer event, Emitter<BxSplashScreenControllerState> emit) async {
    final onBoardingCompleted = await _sharedPreferencesDataSource.getBool(BxSharedPreferencesKeys.onboardingCompleted) ?? false;
    if (state.status == BxSplashScreenStatus.success) {
      emit(state.copyWith(status: BxSplashScreenStatus.initial, onBoardingCompleted: onBoardingCompleted));
    }
    if (state.status == BxSplashScreenStatus.loading) {
      return;
    }
    emit(state.copyWith(status: BxSplashScreenStatus.loading, onBoardingCompleted: onBoardingCompleted));
    await Future.delayed(const Duration(seconds: 3));
    // Check user data and get APNs token if needed
    emit(state.copyWith(status: BxSplashScreenStatus.success));
  }

  Future<void> _onResetSplashScreen(BxResetSplashScreen event, Emitter<BxSplashScreenControllerState> emit) async {
    emit(state.copyWith(status: BxSplashScreenStatus.initial));
    // Start timer again after reset
    add(const BxStartSplashTimer());
  }

  Future<void> _onCheckAndStartSplash(BxCheckAndStartSplash event, Emitter<BxSplashScreenControllerState> emit) async {
    // If state is success, reset and start
    if (state.status == BxSplashScreenStatus.success) {
      add(const BxResetSplashScreen());
    }
    // If state is initial, start timer
    else if (state.status == BxSplashScreenStatus.initial) {
      add(const BxStartSplashTimer());
    }
    // If state is loading, do nothing
    else {}
  }
}
