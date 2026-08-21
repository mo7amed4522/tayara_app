part of 'bx_sign_up_controller_bloc.dart';

enum BxSignUpControllerStatus { initial, loading, success, error }

class BxSignUpControllerState extends Equatable {
  final BxSignUpControllerStatus status;
  final String? errorMessage;
  final BxFirebaseLoginResponse? loginResponse;

  const BxSignUpControllerState({
    this.status = BxSignUpControllerStatus.initial,
    this.errorMessage,
    this.loginResponse,
  });

  @override
  List<Object?> get props => [status, errorMessage, loginResponse];

  BxSignUpControllerState copyWith({
    BxSignUpControllerStatus? status,
    String? errorMessage,
    BxFirebaseLoginResponse? loginResponse,
  }) {
    return BxSignUpControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loginResponse: loginResponse ?? this.loginResponse,
    );
  }
}
