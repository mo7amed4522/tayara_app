// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Profile Bottom Screen Controller
// Purpose: BLoC for managing profile bottom screen state, theme toggle and persistence
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';
import 'package:tayara/domain/usecase/bx_profile_usecase.dart';

part 'bx_profile_bottom_screen_controller_event.dart';
part 'bx_profile_bottom_screen_controller_state.dart';

class BxProfileBottomScreenControllerBloc
    extends
        Bloc<
          BxProfileBottomScreenControllerEvent,
          BxProfileBottomScreenControllerState
        > {
  final BxSharedPreferencesDataSource _sharedPreferencesDataSource;
  final BxProfileUsecase _profileUsecase;

  BxProfileBottomScreenControllerBloc({
    required BxSharedPreferencesDataSource sharedPreferencesDataSource,
    required BxProfileUsecase profileUsecase,
  }) : _sharedPreferencesDataSource = sharedPreferencesDataSource,
       _profileUsecase = profileUsecase,
       super(
         const BxProfileBottomScreenControllerState(
           status: BxProfileBottomScreenControllerStatus.initial,
           isDarkMode: false,
         ),
       ) {
    on<BxLoadProfileThemeEvent>(_onLoadTheme);
    on<BxToggleProfileThemeEvent>(_onToggleTheme);
    on<BxLoadProfileEvent>(_onLoadProfile);
  }

  Future<void> _onLoadTheme(
    BxLoadProfileThemeEvent event,
    Emitter<BxProfileBottomScreenControllerState> emit,
  ) async {
    try {
      final savedTheme = await _sharedPreferencesDataSource.getThemeMode();
      final isDarkMode = savedTheme == 'dark';
      emit(state.copyWith(isDarkMode: isDarkMode));
    } catch (_) {
      emit(state.copyWith(isDarkMode: false));
    }
  }

  Future<void> _onToggleTheme(
    BxToggleProfileThemeEvent event,
    Emitter<BxProfileBottomScreenControllerState> emit,
  ) async {
    try {
      final newIsDarkMode = !state.isDarkMode;
      await _sharedPreferencesDataSource.saveThemeMode(
        newIsDarkMode ? 'dark' : 'light',
      );
      emit(state.copyWith(isDarkMode: newIsDarkMode));
    } catch (_) {
      // Ignore persistence errors; still update UI state
      emit(state.copyWith(isDarkMode: !state.isDarkMode));
    }
  }

  Future<void> _onLoadProfile(
    BxLoadProfileEvent event,
    Emitter<BxProfileBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxProfileBottomScreenControllerStatus.loading));
    try {
      final result = await _profileUsecase.loadProfile();
      if (result.data != null) {
        emit(
          state.copyWith(
            status: BxProfileBottomScreenControllerStatus.success,
            firebaseUser: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxProfileBottomScreenControllerStatus.failure,
            errorMessage: result.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxProfileBottomScreenControllerStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
