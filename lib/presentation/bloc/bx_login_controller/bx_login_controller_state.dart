// File: lib/presentation/bloc/bx_login_controller/bx_login_controller_state.dart
// Architecture: Presentation Layer - Login Controller
// Purpose: State management for login functionality

part of 'bx_login_controller_bloc.dart';

enum BxLoginControllerStatus { initial, loading, success, error }

class BxLoginControllerState extends Equatable {
  final BxLoginControllerStatus status;
  final String? errorMessage;

  const BxLoginControllerState({this.status = BxLoginControllerStatus.initial, this.errorMessage});

  @override
  List<Object?> get props => [status, errorMessage];

  BxLoginControllerState copyWith({BxLoginControllerStatus? status, String? errorMessage}) {
    return BxLoginControllerState(status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);
  }
}
