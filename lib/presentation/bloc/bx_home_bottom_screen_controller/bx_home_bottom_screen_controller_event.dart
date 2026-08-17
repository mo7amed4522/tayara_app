// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_event.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: Event class for handling user interactions in the home bottom screen
// ignore_for_file: prefer_initializing_formals
part of 'bx_home_bottom_screen_controller_bloc.dart';

abstract class BxHomeBottomScreenControllerEvent extends Equatable {
  const BxHomeBottomScreenControllerEvent();

  @override
  List<Object> get props => [];
}

class BxLoadAdsEvent extends BxHomeBottomScreenControllerEvent {
  const BxLoadAdsEvent();
}

class BxAdPageChanged extends BxHomeBottomScreenControllerEvent {
  final int pageIndex;

  const BxAdPageChanged({required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}
