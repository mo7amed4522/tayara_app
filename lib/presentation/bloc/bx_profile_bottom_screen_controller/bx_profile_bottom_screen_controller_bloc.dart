// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Profile Bottom Screen Controller
// Purpose: BLoC for managing profile bottom screen state, theme toggle and persistence
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/domain/model/response/bx_get_user_data_response.dart';
import 'package:tayara/domain/usecase/bx_delete_user_data_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_user_data_usecase.dart';

part 'bx_profile_bottom_screen_controller_event.dart';
part 'bx_profile_bottom_screen_controller_state.dart';

class BxProfileBottomScreenControllerBloc
    extends
        Bloc<
          BxProfileBottomScreenControllerEvent,
          BxProfileBottomScreenControllerState
        > {
  final BxSharedPreferencesDataSource _sharedPreferencesDataSource;
  final BxGetUserDataUsecase _getUserDataUsecase;
  final BxDeleteUserDataUsecase _deleteUserDataUsecase;

  BxProfileBottomScreenControllerBloc({
    required BxSharedPreferencesDataSource sharedPreferencesDataSource,
    required BxGetUserDataUsecase getUserDataUsecase,
    required BxDeleteUserDataUsecase deleteUserDataUsecase,
  }) : _sharedPreferencesDataSource = sharedPreferencesDataSource,
       _getUserDataUsecase = getUserDataUsecase,
       _deleteUserDataUsecase = deleteUserDataUsecase,
       super(
         const BxProfileBottomScreenControllerState(
           status: BxProfileBottomScreenControllerStatus.initial,
           isDarkMode: false,
           isNotificationsEnabled: true,
         ),
       ) {
    on<BxLoadProfileThemeEvent>(_onLoadTheme);
    on<BxToggleProfileThemeEvent>(_onToggleTheme);
    on<BxLoadProfileEvent>(_onLoadProfile);
    on<BxToggleNotificationsEvent>(_onToggleNotifications);
    on<BxDeleteAccountEvent>(_onDeleteAccount);
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
    if (state.status == BxProfileBottomScreenControllerStatus.loading ||
        state.status == BxProfileBottomScreenControllerStatus.success) {
      return;
    }

    final token = BxAppData.currentUser?.data?.token;
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          status: BxProfileBottomScreenControllerStatus.failure,
          errorMessage: 'You are not logged in.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: BxProfileBottomScreenControllerStatus.loading,
        errorMessage: null,
      ),
    );

    final response = await _getUserDataUsecase.execute(token);

    if (response.code == 0 && response.data != null) {
      emit(
        state.copyWith(
          status: BxProfileBottomScreenControllerStatus.success,
          user: response.data!.user,
          pastTrips: response.data!.pastTrips ?? 0,
          upcoming: response.data!.upcoming ?? 0,
          favorites: response.data!.favorites ?? 0,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BxProfileBottomScreenControllerStatus.failure,
          errorMessage: response.msg,
        ),
      );
    }
  }

  /// Toggles the notifications switch. Persist here later if needed.
  void _onToggleNotifications(
    BxToggleNotificationsEvent event,
    Emitter<BxProfileBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(isNotificationsEnabled: !state.isNotificationsEnabled));
  }

  Future<void> _onDeleteAccount(
    BxDeleteAccountEvent event,
    Emitter<BxProfileBottomScreenControllerState> emit,
  ) async {
    final token = BxAppData.currentUser?.data?.token;
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          status: BxProfileBottomScreenControllerStatus.failure,
          errorMessage: 'You are not logged in.',
        ),
      );
      return;
    }

    emit(state.copyWith(isDeleting: true, errorMessage: null));

    final response = await _deleteUserDataUsecase.execute(token: token);

    if (response.code == 0) {
      emit(
        state.copyWith(
          isDeleting: false,
          isAccountDeleted: true,
          status: BxProfileBottomScreenControllerStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isDeleting: false,
          status: BxProfileBottomScreenControllerStatus.failure,
          errorMessage: response.msg,
        ),
      );
    }
  }
}
