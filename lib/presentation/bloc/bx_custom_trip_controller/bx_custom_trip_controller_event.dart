// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_custom_trip_controller/bx_custom_trip_controller_event.dart
// Architecture: Presentation Layer - Custom Trip Screen Controller
// Purpose: Events for custom trip screen BLoC

part of 'bx_custom_trip_controller_bloc.dart';

abstract class BxCustomTripControllerEvent extends Equatable {
  const BxCustomTripControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxLoadCustomTrip extends BxCustomTripControllerEvent {
  const BxLoadCustomTrip();
}

class BxSelectSegment extends BxCustomTripControllerEvent {
  final int segmentIndex;
  const BxSelectSegment({required this.segmentIndex});
  @override
  List<Object?> get props => [segmentIndex];
}

class BxSelectDestination extends BxCustomTripControllerEvent {
  final String destination;
  const BxSelectDestination({required this.destination});
  @override
  List<Object?> get props => [destination];
}

class BxAdvanceStep extends BxCustomTripControllerEvent {
  const BxAdvanceStep();
}
