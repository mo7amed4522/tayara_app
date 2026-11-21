// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_state.dart
// Architecture: Presentation Layer - Update Profile Screen Controller
// Purpose: State management for the update profile screen
part of 'bx_update_profile_screen_controller_bloc.dart';

enum BxUpdateProfileScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxUpdateProfileScreenControllerState extends Equatable {
  final BxUpdateProfileScreenControllerStatus status;
  final String? errorMessage;

  final String phoneCountryCode;
  final String nationality;
  final DateTime? dateOfBirth;

  /// The avatar URL currently stored on the server (for display only).
  final String? existingHeaderImgUrl;

  /// A locally-picked replacement that has not been uploaded yet.
  final XFile? pickedHeaderImage;

  const BxUpdateProfileScreenControllerState({
    this.status = BxUpdateProfileScreenControllerStatus.initial,
    this.errorMessage,
    this.phoneCountryCode = '+971',
    this.nationality = '',
    this.dateOfBirth,
    this.existingHeaderImgUrl,
    this.pickedHeaderImage,
  });

  bool get isSubmitting =>
      status == BxUpdateProfileScreenControllerStatus.loading;

  bool get hasPendingImage => pickedHeaderImage != null;

  /// Prefer the freshly-picked local file so the user sees an instant
  /// preview; otherwise fall back to the server URL.
  String? get displayHeaderImg =>
      pickedHeaderImage?.path ?? existingHeaderImgUrl;

  BxUpdateProfileScreenControllerState copyWith({
    BxUpdateProfileScreenControllerStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? phoneCountryCode,
    String? nationality,
    DateTime? dateOfBirth,
    bool clearDateOfBirth = false,
    String? existingHeaderImgUrl,
    XFile? pickedHeaderImage,
    bool clearPickedHeaderImage = false,
  }) {
    return BxUpdateProfileScreenControllerState(
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      nationality: nationality ?? this.nationality,
      dateOfBirth: clearDateOfBirth ? null : (dateOfBirth ?? this.dateOfBirth),
      existingHeaderImgUrl: existingHeaderImgUrl ?? this.existingHeaderImgUrl,
      pickedHeaderImage: clearPickedHeaderImage
          ? null
          : (pickedHeaderImage ?? this.pickedHeaderImage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    phoneCountryCode,
    nationality,
    dateOfBirth,
    existingHeaderImgUrl,
    pickedHeaderImage?.path,
  ];
}
