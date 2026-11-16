// Copyright (c) 2026 Tayara.
//
// File: lib/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_bloc.dart
// Architecture: Presentation Layer - Bx Package Detail Screen Controller
// Purpose: BLoC for managing package detail screen state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/request/bx_get_package_detail_request.dart';
import 'package:tayara/domain/model/response/bx_get_package_detail_response.dart';
import 'package:tayara/domain/usecase/bx_get_package_detail_usecase.dart';

part 'bx_package_detail_screen_controller_event.dart';
part 'bx_package_detail_screen_controller_state.dart';

class BxPackageDetailScreenControllerBloc
    extends
        Bloc<
          BxPackageDetailScreenControllerEvent,
          BxPackageDetailScreenControllerState
        > {
  final BxGetPackageDetailUsecase _getPackageDetailUsecase;

  BxPackageDetailScreenControllerBloc({
    required BxGetPackageDetailUsecase getPackageDetailUsecase,
  }) : _getPackageDetailUsecase = getPackageDetailUsecase,
       super(const BxPackageDetailScreenControllerState()) {
    on<BxLoadPackageDetail>(_onLoadPackageDetail);
    on<BxChangeImage>(_onChangeImage);
    on<BxSelectDate>(_onSelectDate);
    on<BxSetUserRating>(_onSetUserRating);
    on<BxToggleAddOn>(_onToggleAddOn);
    on<BxSelectCabin>(_onSelectCabin);
  }

  Future<void> _onLoadPackageDetail(
    BxLoadPackageDetail event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) async {
    emit(
      state.copyWith(
        packageId: event.packageId,
        status: BxPackageDetailScreenControllerStatus.loading,
      ),
    );
    try {
      final request = BxGetPackageDetailRequest(id: event.packageId);
      final response = await _getPackageDetailUsecase.execute(request);

      if (response.code == 0 && response.data != null) {
        emit(
          state.copyWith(
            status: BxPackageDetailScreenControllerStatus.success,
            packageDetail: response,
          ),
        );
      } else {
        emit(
          state.copyWith(status: BxPackageDetailScreenControllerStatus.failure),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(status: BxPackageDetailScreenControllerStatus.failure),
      );
    }
  }

  void _onChangeImage(
    BxChangeImage event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) {
    emit(state.copyWith(currentImageIndex: event.index));
  }

  void _onSelectDate(
    BxSelectDate event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) {
    emit(state.copyWith(selectedDateIndex: event.index));
  }

  void _onSetUserRating(
    BxSetUserRating event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) {
    emit(state.copyWith(userRating: event.rating));
  }

  void _onToggleAddOn(
    BxToggleAddOn event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) {
    final selected = List<int>.from(state.selectedAddOns);
    if (selected.contains(event.index)) {
      selected.remove(event.index);
    } else {
      selected.add(event.index);
    }
    emit(state.copyWith(selectedAddOns: selected));
  }

  void _onSelectCabin(
    BxSelectCabin event,
    Emitter<BxPackageDetailScreenControllerState> emit,
  ) {
    emit(state.copyWith(selectedCabinIndex: event.index));
  }
}
