part of 'bx_enter_phone_controller_bloc.dart';

enum BxEnterPhoneControllerStatus { initial, loading, success, error }

class BxEnterPhoneControllerState extends Equatable {
  final BxEnterPhoneControllerStatus status;
  final String? errorMessage;
  final BxFirebaseLoginResponse? loginResponse;
  final String? phoneVerificationId;

  const BxEnterPhoneControllerState({
    this.status = BxEnterPhoneControllerStatus.initial,
    this.errorMessage,
    this.loginResponse,
    this.phoneVerificationId,
  });

  @override
  List<Object?> get props => [status, errorMessage, loginResponse, phoneVerificationId];

  BxEnterPhoneControllerState copyWith({
    BxEnterPhoneControllerStatus? status,
    String? errorMessage,
    BxFirebaseLoginResponse? loginResponse,
    String? phoneVerificationId,
  }) {
    return BxEnterPhoneControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loginResponse: loginResponse ?? this.loginResponse,
      phoneVerificationId: phoneVerificationId ?? this.phoneVerificationId,
    );
  }
}
