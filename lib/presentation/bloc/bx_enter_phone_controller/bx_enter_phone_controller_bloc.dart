// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_enter_phone_controller/bx_enter_phone_controller_bloc.dart
// Architecture: Presentation Layer - Enter Phone Controller
// Purpose: BLoC for managing phone number entry and OTP verification state

// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/services/bx_phone_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_apple_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_facebook_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_google_auth_firebase_services.dart';
import 'package:tayara/domain/model/request/bx_firebase_login_request.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';

part 'bx_enter_phone_controller_event.dart';
part 'bx_enter_phone_controller_state.dart';

class BxEnterPhoneControllerBloc
    extends Bloc<BxEnterPhoneControllerEvent, BxEnterPhoneControllerState> {
  final BxFirebaseLoginUsecase _useCase;

  BxEnterPhoneControllerBloc({required BxFirebaseLoginUsecase useCase})
    : _useCase = useCase,
      super(const BxEnterPhoneControllerState()) {
    on<BxSendPhoneOtp>(_onSendPhoneOtp);
    on<BxVerifyPhoneOtp>(_onVerifyPhoneOtp);
    on<BxSignUpWithGoogle>(_onSignUpWithGoogle);
    on<BxSignUpWithApple>(_onSignUpWithApple);
    on<BxSignUpWithFacebook>(_onSignUpWithFacebook);
  }

  Future<void> _onSendPhoneOtp(
    BxSendPhoneOtp event,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxEnterPhoneControllerStatus.loading));
    try {
      final result = await BxPhoneAuthFirebaseServices.instance
          .sendVerificationCode(phoneNumber: event.phoneNumber);
      if (!result.success) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: result.error ?? 'Failed to send OTP',
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.initial,
          phoneVerificationId: result.verificationId,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onVerifyPhoneOtp(
    BxVerifyPhoneOtp event,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxEnterPhoneControllerStatus.loading));
    try {
      final verificationId = state.phoneVerificationId;
      if (verificationId == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage:
                'No verification ID found. Please request a new code.',
          ),
        );
        return;
      }
      final result = await BxPhoneAuthFirebaseServices.instance.verifyCode(
        phoneNumber: event.phoneNumber,
        smsCode: event.smsCode,
        verificationId: verificationId,
      );
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: result.error ?? 'Verification failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: 'Failed to obtain Firebase ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpWithGoogle(
    BxSignUpWithGoogle event,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxEnterPhoneControllerStatus.loading));
    try {
      final result = await BxGoogleAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: result.error ?? 'Google sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: 'Failed to obtain Google ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpWithApple(
    BxSignUpWithApple event,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxEnterPhoneControllerStatus.loading));
    try {
      final result = await BxAppleAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: result.error ?? 'Apple sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: 'Failed to obtain Apple ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSignUpWithFacebook(
    BxSignUpWithFacebook event,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxEnterPhoneControllerStatus.loading));
    try {
      final result = await BxFacebookAuthFirebaseServices.instance.signIn();
      if (!result.success || result.user == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: result.error ?? 'Facebook sign-up failed',
          ),
        );
        return;
      }
      final idToken = await result.user!.user!.getIdToken();
      if (idToken == null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage: 'Failed to obtain Facebook ID token.',
          ),
        );
        return;
      }
      await _callLoginUseCase(idToken, emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _callLoginUseCase(
    String idToken,
    Emitter<BxEnterPhoneControllerState> emit,
  ) async {
    try {
      final response = await _useCase.execute(
        BxFirebaseLoginRequest(idToken: idToken),
      );
      if (response.code == 0 && response.data != null) {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.success,
            loginResponse: response,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxEnterPhoneControllerStatus.error,
            errorMessage:
                response.message ?? 'Sign-up failed. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxEnterPhoneControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
