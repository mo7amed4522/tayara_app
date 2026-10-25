// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_bloc.dart
// Architecture: Presentation Layer - Search Controller
// Purpose: BLoC for managing search screen state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_search_screen_controller_event.dart';
part 'bx_search_screen_controller_state.dart';

class BxSearchScreenControllerBloc
    extends Bloc<BxSearchScreenControllerEvent, BxSearchScreenControllerState> {
  BxSearchScreenControllerBloc()
    : super(const BxSearchScreenControllerState()) {
    on<BxLoadSearch>(_onLoadSearch);
    on<BxUpdateSearchQuery>(_onUpdateSearchQuery);
  }

  void _onLoadSearch(
    BxLoadSearch event,
    Emitter<BxSearchScreenControllerState> emit,
  ) {
    emit(state.copyWith(status: BxSearchScreenControllerStatus.success));
  }

  void _onUpdateSearchQuery(
    BxUpdateSearchQuery event,
    Emitter<BxSearchScreenControllerState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }
}
