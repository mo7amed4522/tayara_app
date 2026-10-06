// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: BLoC for managing home bottom screen tab navigation and ad carousel state
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_home_bottom_screen_controller_state.dart';
part 'bx_home_bottom_screen_controller_event.dart';

class BxHomeBottomScreenControllerBloc
    extends
        Bloc<
          BxHomeBottomScreenControllerEvent,
          BxHomeBottomScreenControllerState
        > {
  BxHomeBottomScreenControllerBloc()
    : super(const BxHomeBottomScreenControllerState()) {
    on<BxLoadAdsEvent>(_onLoadAds);
    on<BxAdPageChanged>(_onAdPageChanged);
  }

  Future<void> _onLoadAds(
    BxLoadAdsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.loading));
  }

  void _onAdPageChanged(
    BxAdPageChanged event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }
}
