// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: BLoC for managing explore bottom screen state (trending trips, categories, themes, hero carousel)
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';

part 'bx_explore_bottom_screen_controller_event.dart';
part 'bx_explore_bottom_screen_controller_state.dart';

class BxExploreBottomScreenControllerBloc
    extends
        Bloc<
          BxExploreBottomScreenControllerEvent,
          BxExploreBottomScreenControllerState
        > {
  BxExploreBottomScreenControllerBloc()
    : super(const BxExploreBottomScreenControllerState()) {
    on<BxLoadExploreContent>(_onLoadExploreContent);
  }

  void _onLoadExploreContent(
    BxLoadExploreContent event,
    Emitter<BxExploreBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(status: BxExploreBottomScreenControllerStatus.loading));
    try {
      final destinations = [
        {'image': BxAppConstant.baliImage, 'name': 'Bali', 'trips': '48 trips'},
        {
          'image': BxAppConstant.pairsImage,
          'name': 'Paris',
          'trips': '62 trips',
        },
        {
          'image': BxAppConstant.tokyoImage,
          'name': 'Tokyo',
          'trips': '35 trips',
        },
        {
          'image': BxAppConstant.swazirelandImage,
          'name': 'Switzerland',
          'trips': '29 trips',
        },
      ];
      final trendingTrips = [
        {
          'image': BxAppConstant.recommendImage1,
          'name': 'Bali Paradise 5D/4N',
          'price': 'From \$890',
          'rating': '4.8 (210 reviews)',
        },
        {
          'image': BxAppConstant.recommendImage2,
          'name': 'Paris Romance 4D/3N',
          'price': 'From \$1,100',
          'rating': '4.9 (185 reviews)',
        },
        {
          'image': BxAppConstant.recommendImage1,
          'name': 'Tokyo Discovery 6D/5N',
          'price': 'From \$1,350',
          'rating': '4.7 (142 reviews)',
        },
      ];
      final themes = [
        {
          'image': BxAppConstant.baliImage,
          'name': 'Adventure Trips',
          'description': 'Exciting outdoor experiences',
        },
        {
          'image': BxAppConstant.pairsImage,
          'name': 'Luxury Escapes',
          'description': 'Premium travel packages',
        },
        {
          'image': BxAppConstant.tokyoImage,
          'name': 'Cultural Journeys',
          'description': 'Immersive local experiences',
        },
        {
          'image': BxAppConstant.eyeBirdImage,
          'name': 'Honeymoon Deals',
          'description': 'Romantic getaways for two',
        },
        {
          'image': BxAppConstant.swazirelandImage,
          'name': 'Family Holidays',
          'description': 'Fun for all ages',
        },
        {
          'image': BxAppConstant.recommendImage2,
          'name': 'Friends Trip',
          'description': 'Group adventures & bondings',
        },
      ];
      final heroAds = [
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Top Summer Getaways',
          'subtitle': 'Discover amazing destinations',
          'buttonText': 'Explore Now',
        },
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Winter Wonderland',
          'subtitle': 'Ski trips & cozy retreats',
          'buttonText': 'View Deals',
        },
        {
          'imageUrl': BxAppConstant.adsBackground,
          'title': 'Island Adventures',
          'subtitle': 'Paradise beaches await',
          'buttonText': 'Book Now',
        },
      ];
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
