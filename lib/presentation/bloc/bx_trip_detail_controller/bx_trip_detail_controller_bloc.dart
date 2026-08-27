// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_trip_detail_controller/bx_trip_detail_controller_bloc.dart
// Architecture: Presentation Layer - Trip Detail Controller
// Purpose: BLoC for managing trip detail state
// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/response/bx_package_response.dart';
import 'package:tayara/domain/usecase/bx_package_usecase.dart';

part 'bx_trip_detail_controller_event.dart';
part 'bx_trip_detail_controller_state.dart';

class BxTripDetailControllerBloc
    extends Bloc<BxTripDetailControllerEvent, BxTripDetailControllerState> {
  final BxPackageUsecase _packageUsecase;

  BxTripDetailControllerBloc({required BxPackageUsecase packageUsecase})
    : _packageUsecase = packageUsecase,
      super(const BxTripDetailControllerState()) {
    on<BxLoadTripDetail>(_onLoadTripDetail);
    on<BxToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadTripDetail(
    BxLoadTripDetail event,
    Emitter<BxTripDetailControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxTripDetailControllerStatus.loading));
    try {
      final packageId = int.tryParse(event.tripId) ?? 0;
      if (packageId <= 0) {
        emit(
          state.copyWith(
            status: BxTripDetailControllerStatus.error,
            errorMessage: 'Invalid trip ID',
          ),
        );
        return;
      }
      final result = await _packageUsecase.loadPackageDetail(packageId);
      if (result.data != null) {
        emit(
          state.copyWith(
            status: BxTripDetailControllerStatus.success,
            package: result.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BxTripDetailControllerStatus.error,
            errorMessage: result.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BxTripDetailControllerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onToggleFavorite(
    BxToggleFavorite event,
    Emitter<BxTripDetailControllerState> emit,
  ) {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }
}
