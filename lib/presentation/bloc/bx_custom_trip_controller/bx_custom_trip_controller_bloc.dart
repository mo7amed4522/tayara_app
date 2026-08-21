// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_custom_trip_controller/bx_custom_trip_controller_bloc.dart
// Architecture: Presentation Layer - Custom Trip Controller
// Purpose: BLoC for managing custom trip planning screen state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_custom_trip_controller_event.dart';
part 'bx_custom_trip_controller_state.dart';

class BxCustomTripControllerBloc
    extends Bloc<BxCustomTripControllerEvent, BxCustomTripControllerState> {
  BxCustomTripControllerBloc() : super(const BxCustomTripControllerState()) {
    on<BxLoadCustomTrip>(_onLoadCustomTrip);
    on<BxSelectSegment>(_onSelectSegment);
    on<BxSelectDestination>(_onSelectDestination);
    on<BxAdvanceStep>(_onAdvanceStep);
  }

  void _onLoadCustomTrip(
    BxLoadCustomTrip event,
    Emitter<BxCustomTripControllerState> emit,
  ) {
    emit(state.copyWith(status: BxCustomTripControllerStatus.success));
  }

  void _onSelectSegment(
    BxSelectSegment event,
    Emitter<BxCustomTripControllerState> emit,
  ) {
    emit(state.copyWith(selectedSegment: event.segmentIndex));
  }

  void _onSelectDestination(
    BxSelectDestination event,
    Emitter<BxCustomTripControllerState> emit,
  ) {
    emit(state.copyWith(selectedDestination: event.destination));
  }

  void _onAdvanceStep(
    BxAdvanceStep event,
    Emitter<BxCustomTripControllerState> emit,
  ) {
    final nextStep = (state.activeStep % 5) + 1;
    emit(state.copyWith(activeStep: nextStep));
  }
}
