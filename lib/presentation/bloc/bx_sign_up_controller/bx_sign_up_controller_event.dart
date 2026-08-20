part of 'bx_sign_up_controller_bloc.dart';

abstract class BxSignUpControllerEvent extends Equatable {
  const BxSignUpControllerEvent();
  @override
  List<Object?> get props => [];
}

/// Triggered when user taps "Continue with Google".
class BxSignUpWithGoogle extends BxSignUpControllerEvent {}

/// Triggered when user taps "Continue with Apple".
class BxSignUpWithApple extends BxSignUpControllerEvent {}

/// Triggered when user taps "Continue with Facebook".
class BxSignUpWithFacebook extends BxSignUpControllerEvent {}
