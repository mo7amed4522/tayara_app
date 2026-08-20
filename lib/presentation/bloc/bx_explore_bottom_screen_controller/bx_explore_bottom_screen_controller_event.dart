// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_event.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: Events for explore bottom screen BLoC

part of 'bx_explore_bottom_screen_controller_bloc.dart';

abstract class BxExploreBottomScreenControllerEvent extends Equatable {
  const BxExploreBottomScreenControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxLoadExploreContent extends BxExploreBottomScreenControllerEvent {
  const BxLoadExploreContent();
}
