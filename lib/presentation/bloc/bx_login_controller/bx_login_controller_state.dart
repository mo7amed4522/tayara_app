// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_login_controller/bx_login_controller_state.dart
// Architecture: Presentation Layer - Login Controller
// Purpose: State management for login functionality

part of 'bx_login_controller_bloc.dart';

enum BxLoginControllerStatus { initial, loading, success, error }

class BxLoginControllerState extends Equatable {
  final BxLoginControllerStatus status;
  final String? errorMessage;
  final BxFirebaseLoginResponse? loginResponse;
  final String? phoneVerificationId;

  const BxLoginControllerState({
    this.status = BxLoginControllerStatus.initial,
    this.errorMessage,
    this.loginResponse,
    this.phoneVerificationId,
  });

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    loginResponse,
    phoneVerificationId,
  ];

  BxLoginControllerState copyWith({
    BxLoginControllerStatus? status,
    String? errorMessage,
    BxFirebaseLoginResponse? loginResponse,
    String? phoneVerificationId,
  }) {
    return BxLoginControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loginResponse: loginResponse ?? this.loginResponse,
      phoneVerificationId: phoneVerificationId ?? this.phoneVerificationId,
    );
  }
}
