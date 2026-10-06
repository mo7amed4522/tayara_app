// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_trip_detail_controller/bx_trip_detail_controller_bloc.dart
// Architecture: Presentation Layer - Trip Detail Controller
// Purpose: BLoC for managing trip detail state
// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_trip_detail_controller_event.dart';
part 'bx_trip_detail_controller_state.dart';

class BxTripDetailControllerBloc
    extends Bloc<BxTripDetailControllerEvent, BxTripDetailControllerState> {
  BxTripDetailControllerBloc() : super(const BxTripDetailControllerState()) {
    on<BxLoadTripDetail>(_onLoadTripDetail);
    on<BxToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadTripDetail(
    BxLoadTripDetail event,
    Emitter<BxTripDetailControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxTripDetailControllerStatus.loading));
  }

  void _onToggleFavorite(
    BxToggleFavorite event,
    Emitter<BxTripDetailControllerState> emit,
  ) {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }
}
