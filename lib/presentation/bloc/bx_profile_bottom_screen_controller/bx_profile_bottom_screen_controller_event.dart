// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_event.dart
// Architecture: Presentation Layer - Profile Bottom Screen Controller
// Purpose: Define events for profile bottom screen controller BLoC

part of 'bx_profile_bottom_screen_controller_bloc.dart';

abstract class BxProfileBottomScreenControllerEvent extends Equatable {
  const BxProfileBottomScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxLoadProfileThemeEvent extends BxProfileBottomScreenControllerEvent {}

class BxToggleProfileThemeEvent extends BxProfileBottomScreenControllerEvent {}
