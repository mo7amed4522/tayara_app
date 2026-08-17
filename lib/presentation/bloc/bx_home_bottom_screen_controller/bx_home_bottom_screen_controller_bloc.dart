// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: BLoC for managing home bottom screen tab navigation and ad carousel state
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';

part 'bx_home_bottom_screen_controller_state.dart';
part 'bx_home_bottom_screen_controller_event.dart';

class BxHomeBottomScreenControllerBloc
    extends
        Bloc<
          BxHomeBottomScreenControllerEvent,
          BxHomeBottomScreenControllerState
        > {
  BxHomeBottomScreenControllerBloc()
    : super(const BxHomeBottomScreenControllerState()) {
    on<BxLoadAdsEvent>(_onLoadAds);
    on<BxAdPageChanged>(_onAdPageChanged);
  }

  void _onLoadAds(
    BxLoadAdsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.loading));
    try {
      final ads = [
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Maldives Escape',
          'subtitle': '4D/3N luxury stay',
        },
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Bali Beach Vibes',
          'subtitle': '5D/4N tropical getaway',
        },
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Santorini Sunset',
          'subtitle': '3D/2N romantic trip',
        },
      ];
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
