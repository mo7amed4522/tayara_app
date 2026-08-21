// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_enter_phone_controller/bx_enter_phone_controller_event.dart
// Architecture: Presentation Layer - Enter Phone number Screen Controller
// Purpose: Events for enter phone number screen BLoC

part of 'bx_enter_phone_controller_bloc.dart';

abstract class BxEnterPhoneControllerEvent extends Equatable {
  const BxEnterPhoneControllerEvent();
  @override
  List<Object?> get props => [];
}

/// Triggered when user taps "Send OTP" after entering their phone number.
class BxSendPhoneOtp extends BxEnterPhoneControllerEvent {
  final String phoneNumber;
  const BxSendPhoneOtp({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

/// Triggered when user submits the SMS verification code.
class BxVerifyPhoneOtp extends BxEnterPhoneControllerEvent {
  final String phoneNumber;
  final String smsCode;
  const BxVerifyPhoneOtp({required this.phoneNumber, required this.smsCode});
  @override
  List<Object?> get props => [phoneNumber, smsCode];
}

/// Triggered when user taps "Continue with Google".
class BxSignUpWithGoogle extends BxEnterPhoneControllerEvent {}

/// Triggered when user taps "Continue with Apple".
class BxSignUpWithApple extends BxEnterPhoneControllerEvent {}

/// Triggered when user taps "Continue with Facebook".
class BxSignUpWithFacebook extends BxEnterPhoneControllerEvent {}
