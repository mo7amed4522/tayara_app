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
