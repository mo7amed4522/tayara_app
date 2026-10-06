// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: BLoC for managing explore bottom screen state (trending trips, categories, themes, hero carousel)
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_explore_bottom_screen_controller_event.dart';
part 'bx_explore_bottom_screen_controller_state.dart';

class BxExploreBottomScreenControllerBloc
    extends
        Bloc<
          BxExploreBottomScreenControllerEvent,
          BxExploreBottomScreenControllerState
        > {
  BxExploreBottomScreenControllerBloc()
    : super(const BxExploreBottomScreenControllerState()) {
    on<BxLoadExploreContent>(_onLoadExploreContent);
  }

  Future<void> _onLoadExploreContent(
    BxLoadExploreContent event,
    Emitter<BxExploreBottomScreenControllerState> emit,
  ) async {}
}
