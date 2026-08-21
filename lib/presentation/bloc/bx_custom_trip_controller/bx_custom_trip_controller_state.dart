part of 'bx_custom_trip_controller_bloc.dart';

enum BxCustomTripControllerStatus { initial, loading, success, failure }

class BxCustomTripControllerState extends Equatable {
  final BxCustomTripControllerStatus status;
  final int activeStep;
  final int selectedSegment;
  final String? selectedDestination;

  const BxCustomTripControllerState({
    this.status = BxCustomTripControllerStatus.initial,
    this.activeStep = 1,
    this.selectedSegment = 3,
    this.selectedDestination,
  });

  @override
  List<Object?> get props => [status, activeStep, selectedSegment, selectedDestination];

  BxCustomTripControllerState copyWith({
    BxCustomTripControllerStatus? status,
    int? activeStep,
    int? selectedSegment,
    String? selectedDestination,
  }) {
    return BxCustomTripControllerState(
      status: status ?? this.status,
      activeStep: activeStep ?? this.activeStep,
      selectedSegment: selectedSegment ?? this.selectedSegment,
      selectedDestination: selectedDestination ?? this.selectedDestination,
    );
  }
}
