// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart
// Architecture: Presentation Layer - Splash Screen Controller
// Purpose: BLoC for managing splash screen state and persistence
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously

import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/constant/bx_shared_preferences_keys.dart';
import 'package:tayara/core/utils/bx_push_token_helper.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/domain/usecase/bx_upsert_push_token_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_splash_screen_controller_state.dart';
part 'bx_splash_screen_controller_event.dart';

class BxSplashScreenControllerBloc
    extends Bloc<BxSplashScreenControllerEvent, BxSplashScreenControllerState> {
  final BxSharedPreferencesDataSource _sharedPreferencesDataSource;
  final BxUpsertPushTokenUsecase _upsertPushTokenUsecase;

  BxSplashScreenControllerBloc({
    required BxSharedPreferencesDataSource sharedPreferencesDataSource,
    required BxUpsertPushTokenUsecase upsertPushTokenUsecase,
  }) : _sharedPreferencesDataSource = sharedPreferencesDataSource,
       _upsertPushTokenUsecase = upsertPushTokenUsecase,
       super(BxSplashScreenControllerState()) {
    on<BxStartSplashTimer>(_onStartSplashTimer);
    on<BxResetSplashScreen>(_onResetSplashScreen);
    on<BxCheckAndStartSplash>(_onCheckAndStartSplash);
  }

  Future<void> _onStartSplashTimer(
    BxStartSplashTimer event,
    Emitter<BxSplashScreenControllerState> emit,
  ) async {
    final onBoardingCompleted =
        await _sharedPreferencesDataSource.getBool(
          BxSharedPreferencesKeys.onboardingCompleted,
        ) ??
        false;
    BxAppData.currentUser = await _sharedPreferencesDataSource.getUserData();
    if (state.status == BxSplashScreenStatus.success) {
      emit(
        state.copyWith(
          status: BxSplashScreenStatus.initial,
          onBoardingCompleted: onBoardingCompleted,
        ),
      );
    }
    if (state.status == BxSplashScreenStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        status: BxSplashScreenStatus.loading,
        onBoardingCompleted: onBoardingCompleted,
      ),
    );

    // Sync the push token on cold start — but only for a logged-in user.
    // Guests have no token to associate with, and calling the endpoint
    // without auth would just fail with 401.
    await _syncPushTokenIfAuthenticated();

    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(status: BxSplashScreenStatus.success));
  }

  /// Calls the upsert endpoint if a user is currently stored.
  ///
  /// Failures are logged and ignored — they must never block the splash
  /// screen from completing. The token will be retried on the next
  /// `onTokenRefresh` event or the next launch.
  Future<void> _syncPushTokenIfAuthenticated() async {
    final user = BxAppData.currentUser;
    final token = user?.data?.token;
    if (user == null || token == null || token.isEmpty) {
      debugPrint('[Splash] No authenticated user — skipping push token sync.');
      return;
    }

    final request = await BxPushTokenHelper.build(authToken: token);
    if (request == null) {
      debugPrint('[Splash] FCM token not ready — skipping push token sync.');
      return;
    }

    final response = await _upsertPushTokenUsecase.execute(request);
    if (response.code == 0) {
      debugPrint('[Splash] Push token synced successfully.');
    } else {
      debugPrint('[Splash] Push token sync failed: ${response.msg}');
    }
  }

  Future<void> _onResetSplashScreen(
    BxResetSplashScreen event,
    Emitter<BxSplashScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxSplashScreenStatus.initial));
    // Start timer again after reset
    add(const BxStartSplashTimer());
  }

  Future<void> _onCheckAndStartSplash(
    BxCheckAndStartSplash event,
    Emitter<BxSplashScreenControllerState> emit,
  ) async {
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
