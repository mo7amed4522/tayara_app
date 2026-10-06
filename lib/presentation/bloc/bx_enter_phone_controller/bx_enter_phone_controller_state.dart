// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_enter_phone_controller/bx_enter_phone_controller_state.dart
// Architecture: Presentation Layer - Bx Enter phone Screen Controller
// Purpose: State management for the enter phone screen
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously
part of 'bx_enter_phone_controller_bloc.dart';

enum BxEnterPhoneControllerStatus { initial, loading, success, error }

class BxEnterPhoneControllerState extends Equatable {
  final BxEnterPhoneControllerStatus status;
  final String? errorMessage;
  final BxLoginUserResponse? loginResponse;
  final String? phoneVerificationId;

  const BxEnterPhoneControllerState({
    this.status = BxEnterPhoneControllerStatus.initial,
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

  BxEnterPhoneControllerState copyWith({
    BxEnterPhoneControllerStatus? status,
    String? errorMessage,
    BxLoginUserResponse? loginResponse,
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
