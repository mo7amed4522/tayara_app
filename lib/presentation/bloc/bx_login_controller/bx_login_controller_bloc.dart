// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_login_controller/bx_login_controller_bloc.dart
// Architecture: Presentation Layer - Login Controller
// Purpose: BLoC for managing login state and actions

// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/services/bx_apple_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_facebook_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_google_auth_firebase_services.dart';
import 'package:tayara/core/services/bx_phone_auth_firebase_services.dart';
import 'package:tayara/domain/model/request/bx_firebase_login_request.dart';
import 'package:tayara/domain/model/response/bx_firebase_login_response.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';

part 'bx_login_controller_event.dart';
part 'bx_login_controller_state.dart';

class BxLoginControllerBloc
    extends Bloc<BxLoginControllerEvent, BxLoginControllerState> {
  final BxFirebaseLoginUsecase _useCase;

  BxLoginControllerBloc({required BxFirebaseLoginUsecase useCase})
    : _useCase = useCase,
      super(const BxLoginControllerState()) {
    on<BxLoginWithGoogle>((event, emit) async {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      try {
        final googleResult = await BxGoogleAuthFirebaseServices.instance
            .signIn();
        if (!googleResult.success || googleResult.user == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: googleResult.error ?? 'Google sign-in failed',
            ),
          );
          return;
        }
        final idToken = await googleResult.user!.user!.getIdToken();
        if (idToken == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: 'Failed to obtain Google ID token.',
            ),
          );
          return;
        }
        await _callLoginUseCase(idToken, emit);
      } catch (e) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<BxLoginWithApple>((event, emit) async {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      try {
        final appleResult = await BxAppleAuthFirebaseServices.instance.signIn();
        if (!appleResult.success || appleResult.user == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: appleResult.error ?? 'Apple sign-in failed',
            ),
          );
          return;
        }
        final idToken = await appleResult.user!.user!.getIdToken();
        if (idToken == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: 'Failed to obtain Apple ID token.',
            ),
          );
          return;
        }
        await _callLoginUseCase(idToken, emit);
      } catch (e) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<BxLoginWithFacebook>((event, emit) async {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      try {
        final facebookResult = await BxFacebookAuthFirebaseServices.instance
            .signIn();
        if (!facebookResult.success || facebookResult.user == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: facebookResult.error ?? 'Facebook sign-in failed',
            ),
          );
          return;
        }
        final idToken = await facebookResult.user!.user!.getIdToken();
        if (idToken == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: 'Failed to obtain Facebook ID token.',
            ),
          );
          return;
        }
        await _callLoginUseCase(idToken, emit);
      } catch (e) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<BxLoginWithPhone>((event, emit) async {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      try {
        final phoneResult = await BxPhoneAuthFirebaseServices.instance
            .sendVerificationCode(phoneNumber: event.phoneNumber);
        if (!phoneResult.success) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage:
                  phoneResult.error ?? 'Failed to send verification code',
            ),
          );
          return;
        }
        // Store the verification ID so the next event can use it.
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.initial,
            phoneVerificationId: phoneResult.verificationId,
            errorMessage: null,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<BxLoginWithPhoneCode>((event, emit) async {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      try {
        final verificationId = state.phoneVerificationId;
        if (verificationId == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage:
                  'No verification ID found. Please request a new code.',
            ),
          );
          return;
        }
        final phoneResult = await BxPhoneAuthFirebaseServices.instance
            .verifyCode(
              phoneNumber: event.phoneNumber,
              smsCode: event.smsCode,
              verificationId: verificationId,
            );
        if (!phoneResult.success || phoneResult.user == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: phoneResult.error ?? 'Verification failed',
            ),
          );
          return;
        }
        final idToken = await phoneResult.user!.user!.getIdToken();
        if (idToken == null) {
          emit(
            state.copyWith(
              status: BxLoginControllerStatus.error,
              errorMessage: 'Failed to obtain Firebase ID token.',
            ),
          );
          return;
        }
        await _callLoginUseCase(idToken, emit);
      } catch (e) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<BxLoginTermsPressed>((event, emit) {});

    on<BxLoginPrivacyPressed>((event, emit) {});
  }

  /// Common handler: calls the login use case and maps the response to state.
  Future<void> _callLoginUseCase(
    String idToken,
    Emitter<BxLoginControllerState> emit,
  ) async {
    try {
      final request = BxFirebaseLoginRequest(idToken: idToken);
      final response = await _useCase.execute(request);
      if (response.code == 0 && response.data != null) {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.success,
            loginResponse: response,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxLoginControllerStatus.error,
            errorMessage: response.message ?? 'Login failed. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxLoginControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
