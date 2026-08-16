// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_event.dart
// Architecture: Presentation Layer - Home Screen Controller
// Purpose: Define events for home screen controller BLoC
part of 'bx_home_screen_controller_bloc.dart';

abstract class BxHomeScreenControllerEvent extends Equatable {
  const BxHomeScreenControllerEvent();

  @override
  List<Object?> get props => [];
}

class BxChangeHomeTab extends BxHomeScreenControllerEvent {
  final int tabIndex;

  const BxChangeHomeTab({required this.tabIndex});

  @override
  List<Object?> get props => [tabIndex];
}
