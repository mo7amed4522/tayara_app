// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: BLoC for managing explore bottom screen state (trending trips, categories, themes, hero carousel)
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/usecase/bx_home_usecase.dart';

part 'bx_explore_bottom_screen_controller_event.dart';
part 'bx_explore_bottom_screen_controller_state.dart';

class BxExploreBottomScreenControllerBloc
    extends
        Bloc<
          BxExploreBottomScreenControllerEvent,
          BxExploreBottomScreenControllerState
        > {
  final BxHomeUsecase _homeUsecase;

  BxExploreBottomScreenControllerBloc({required BxHomeUsecase homeUsecase})
    : _homeUsecase = homeUsecase,
      super(const BxExploreBottomScreenControllerState()) {
    on<BxLoadExploreContent>(_onLoadExploreContent);
  }

  Future<void> _onLoadExploreContent(
    BxLoadExploreContent event,
    Emitter<BxExploreBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxExploreBottomScreenControllerStatus.loading));
    try {
      final exploreResult = await _homeUsecase.loadExploreTrips(
        BxCustomerExploreRequest(),
      );
      final destinations = exploreResult.trips.map((dest) {
        return <String, String>{
          'image': dest.coverImageURL ?? BxAppConstant.baliImage,
          'name': dest.name ?? '',
          'trips': '${dest.daysDuration ?? 0} trips',
        };
      }).toList();

      final trendingTrips = exploreResult.trips.map((trip) {
        return <String, String>{
          'image': trip.coverImageURL ?? BxAppConstant.recommendImage1,
          'name': trip.name ?? '',
          'price': 'From \$${trip.displayPrice ?? 0}',
          'rating': trip.rating != null
              ? '${trip.rating} (${trip.reviewCount ?? 0} reviews)'
              : '',
        };
      }).toList();

      final themes = exploreResult.trips.map((trip) {
        return <String, String>{
          'image': trip.coverImageURL ?? BxAppConstant.baliImage,
          'name': trip.category ?? 'Explore',
          'description': trip.name ?? '',
        };
      }).toList();

      final heroAds = exploreResult.trips.map((trip) {
        return <String, String>{
          'imageUrl': trip.coverImageURL ?? BxAppConstant.adsBackground,
          'title': trip.name ?? '',
          'subtitle': trip.description ?? '',
          'buttonText': 'Explore Now',
        };
      }).toList();

      emit(
        state.copyWith(
          status: BxExploreBottomScreenControllerStatus.success,
          destinations: destinations,
          trendingTrips: trendingTrips,
          themes: themes,
          heroAds: heroAds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BxExploreBottomScreenControllerStatus.failure),
      );
    }
  }
}
