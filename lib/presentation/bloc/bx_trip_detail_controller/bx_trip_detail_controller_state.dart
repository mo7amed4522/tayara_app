part of 'bx_trip_detail_controller_bloc.dart';

enum BxTripDetailControllerStatus { initial, loading, success, error }

class BxTripDetailControllerState extends Equatable {
  final BxTripDetailControllerStatus status;
  final bool isFavorite;
  final String? errorMessage;

  const BxTripDetailControllerState({
    this.status = BxTripDetailControllerStatus.initial,
    this.isFavorite = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, isFavorite, errorMessage];

  BxTripDetailControllerState copyWith({
    BxTripDetailControllerStatus? status,
    bool? isFavorite,
    String? errorMessage,
  }) {
    return BxTripDetailControllerState(
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
