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
  final BxLoginUserResponse? loginResponse;
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

  /// Sentinel used by [copyWith] to distinguish "not provided" from
  /// "explicitly set to null".
  static const Object _sentinel = Object();

  BxLoginControllerState copyWith({
    BxLoginControllerStatus? status,
    Object? errorMessage = _sentinel,
    BxLoginUserResponse? loginResponse,
    String? phoneVerificationId,
  }) {
    return BxLoginControllerState(
      status: status ?? this.status,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      loginResponse: loginResponse ?? this.loginResponse,
      phoneVerificationId: phoneVerificationId ?? this.phoneVerificationId,
    );
  }
}
