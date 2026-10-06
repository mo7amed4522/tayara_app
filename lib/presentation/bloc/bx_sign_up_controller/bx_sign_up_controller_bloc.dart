// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_sign_up_controller/bx_sign_up_controller_bloc.dart
// Architecture: Presentation Layer - Sign Up Controller
// Purpose: BLoC for managing sign-up state and actions

// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/services/bx_apple_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_facebook_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_google_auth_firebase_services.dart';
import 'package:tayara/domain/model/request/bx_login_user_request.dart';
import 'package:tayara/domain/model/response/bx_login_user_response.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';

part 'bx_sign_up_controller_event.dart';
part 'bx_sign_up_controller_state.dart';

class BxSignUpControllerBloc
    extends Bloc<BxSignUpControllerEvent, BxSignUpControllerState> {
  final BxFirebaseLoginUsecase _useCase;

  BxSignUpControllerBloc({required BxFirebaseLoginUsecase useCase})
    : _useCase = useCase,
      super(const BxSignUpControllerState()) {
    on<BxSignUpWithGoogle>(_onSignUpWithGoogle);
    on<BxSignUpWithApple>(_onSignUpWithApple);
    on<BxSignUpWithFacebook>(_onSignUpWithFacebook);
  }

  Future<void> _onSignUpWithGoogle(
    BxSignUpWithGoogle event,
    Emitter<BxSignUpControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxSignUpControllerStatus.loading));
    try {
      final result = await BxGoogleAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: result.error ?? 'Google sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: 'Failed to obtain Google ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxSignUpControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpWithApple(
    BxSignUpWithApple event,
    Emitter<BxSignUpControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxSignUpControllerStatus.loading));
    try {
      final result = await BxAppleAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: result.error ?? 'Apple sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: 'Failed to obtain Apple ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxSignUpControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpWithFacebook(
    BxSignUpWithFacebook event,
    Emitter<BxSignUpControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxSignUpControllerStatus.loading));
    try {
      final result = await BxFacebookAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: result.error ?? 'Facebook sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: 'Failed to obtain Facebook ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxSignUpControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _callLoginUseCase(
    String idToken,
    Emitter<BxSignUpControllerState> emit,
  ) async {
    try {
      final response = await _useCase.execute(
        BxLoginUserRequest(idToken: idToken),
      );
      if (response.code == 0 && response.data != null) {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.success,
            loginResponse: response,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxSignUpControllerStatus.error,
            errorMessage: response.msg,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxSignUpControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
