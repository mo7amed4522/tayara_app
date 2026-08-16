// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart
// Architecture: Presentation Layer - Home Screen Controller
// Purpose: BLoC for managing home screen tab navigation state
// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_home_screen_controller_state.dart';
part 'bx_home_screen_controller_event.dart';

class BxHomeScreenControllerBloc
    extends Bloc<BxHomeScreenControllerEvent, BxHomeScreenControllerState> {
  BxHomeScreenControllerBloc() : super(const BxHomeScreenControllerState()) {
    on<BxChangeHomeTab>(_onChangeTab);
  }

  void _onChangeTab(
    BxChangeHomeTab event,
    Emitter<BxHomeScreenControllerState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.tabIndex));
  }
}
