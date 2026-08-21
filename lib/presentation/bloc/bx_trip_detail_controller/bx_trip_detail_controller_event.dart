part of 'bx_trip_detail_controller_bloc.dart';

abstract class BxTripDetailControllerEvent extends Equatable {
  const BxTripDetailControllerEvent();
  @override
  List<Object?> get props => [];
}

/// Triggered when the trip detail screen is opened.
class BxLoadTripDetail extends BxTripDetailControllerEvent {
  final String tripId;
  const BxLoadTripDetail({required this.tripId});
  @override
  List<Object?> get props => [tripId];
}

/// Toggle the favourite / wishlist state.
class BxToggleFavorite extends BxTripDetailControllerEvent {}
