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
