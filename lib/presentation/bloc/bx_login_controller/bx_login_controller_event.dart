// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_login_controller/bx_login_controller_event.dart
// Architecture: Presentation Layer - Login Controller
// Purpose: Events for managing login state and actions

part of 'bx_login_controller_bloc.dart';

abstract class BxLoginControllerEvent extends Equatable {
  const BxLoginControllerEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when user taps "Continue with Google".
class BxLoginWithGoogle extends BxLoginControllerEvent {}

/// Triggered when user taps "Continue with Apple".
class BxLoginWithApple extends BxLoginControllerEvent {}

/// Triggered when user taps "Continue with Facebook".
class BxLoginWithFacebook extends BxLoginControllerEvent {}

/// Triggered when user taps "Continue with Phone Number" (step 1: send SMS code).
/// [phoneNumber] is the full international phone number (e.g. '+1234567890').
class BxLoginWithPhone extends BxLoginControllerEvent {
  final String phoneNumber;

  const BxLoginWithPhone({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Triggered when user submits the SMS verification code (step 2: verify code).
class BxLoginWithPhoneCode extends BxLoginControllerEvent {
  final String phoneNumber;
  final String smsCode;

  const BxLoginWithPhoneCode({
    required this.phoneNumber,
    required this.smsCode,
  });

  @override
  List<Object?> get props => [phoneNumber, smsCode];
}

/// Triggered when user taps "Terms of Service".
class BxLoginTermsPressed extends BxLoginControllerEvent {}

/// Triggered when user taps "Privacy Policy".
class BxLoginPrivacyPressed extends BxLoginControllerEvent {}
