// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_event.dart
// Architecture: Presentation Layer - Update Profile Screen Controller
// Purpose: Define events for update profile screen BLoC
part of 'bx_update_profile_screen_controller_bloc.dart';

abstract class BxUpdateProfileScreenControllerEvent extends Equatable {
  const BxUpdateProfileScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxSubmitUpdateProfileEvent extends BxUpdateProfileScreenControllerEvent {
  const BxSubmitUpdateProfileEvent();
}

class BxChangePhoneCountryCodeEvent
    extends BxUpdateProfileScreenControllerEvent {
  final String dialCode;
  const BxChangePhoneCountryCodeEvent(this.dialCode);

  @override
  List<Object?> get props => [dialCode];
}

class BxChangeNationalityEvent extends BxUpdateProfileScreenControllerEvent {
  final String value;
  const BxChangeNationalityEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class BxChangeDateOfBirthEvent extends BxUpdateProfileScreenControllerEvent {
  final DateTime? value;
  const BxChangeDateOfBirthEvent(this.value);

  @override
  List<Object?> get props => [value];
}

/// Opens the platform picker (camera or gallery) and stores the chosen file
/// in state. The file is only uploaded on [BxSubmitUpdateProfileEvent].
class BxPickHeaderImageEvent extends BxUpdateProfileScreenControllerEvent {
  final ImageSource source;
  const BxPickHeaderImageEvent({this.source = ImageSource.gallery});

  @override
  List<Object?> get props => [source];
}

/// Discards the locally-picked image (undo the selection).
/// Note: the API has no "remove avatar" field, so the server image stays.
class BxRemovePickedHeaderImageEvent
    extends BxUpdateProfileScreenControllerEvent {
  const BxRemovePickedHeaderImageEvent();
}

class BxResetUpdateProfileEvent extends BxUpdateProfileScreenControllerEvent {
  const BxResetUpdateProfileEvent();
}
