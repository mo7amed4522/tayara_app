// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: BLoC for managing home bottom screen tab navigation and ad carousel state
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/domain/usecase/bx_home_usecase.dart';

part 'bx_home_bottom_screen_controller_state.dart';
part 'bx_home_bottom_screen_controller_event.dart';

class BxHomeBottomScreenControllerBloc
    extends
        Bloc<
          BxHomeBottomScreenControllerEvent,
          BxHomeBottomScreenControllerState
        > {
  final BxHomeUsecase _homeUsecase;

  BxHomeBottomScreenControllerBloc({required BxHomeUsecase homeUsecase})
    : _homeUsecase = homeUsecase,
      super(const BxHomeBottomScreenControllerState()) {
    on<BxLoadAdsEvent>(_onLoadAds);
    on<BxAdPageChanged>(_onAdPageChanged);
  }

  Future<void> _onLoadAds(
    BxLoadAdsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.loading));
    try {
      final result = await _homeUsecase.loadHomeAds();
      final ads = result.ads.map((ad) {
        return <String, String>{
          'imageUrl': ad.bannerImageURL ?? BxAppConstant.adsBackground,
          'title': ad.overlayTitle ?? '',
          'subtitle': ad.overlaySubtitle ?? '',
          'buttonText': ad.ctaLabel ?? '',
        };
      }).toList();
      emit(
        state.copyWith(
          status: BxHomeBottomScreenControllerStatus.success,
          ads: ads,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.failure));
    }
  }

  void _onAdPageChanged(
    BxAdPageChanged event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }
}
