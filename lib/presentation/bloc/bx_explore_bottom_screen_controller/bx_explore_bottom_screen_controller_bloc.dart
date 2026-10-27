// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: BLoC for managing explore bottom screen state (trending trips, categories, themes, hero carousel)
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/request/bx_get_explore_topic_request.dart';
import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_topic_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/usecase/bx_active_top_banner_ads_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_topic_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_trips_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_agent_usecase.dart';

part 'bx_explore_bottom_screen_controller_event.dart';
part 'bx_explore_bottom_screen_controller_state.dart';

class BxExploreBottomScreenControllerBloc
    extends
        Bloc<
          BxExploreBottomScreenControllerEvent,
          BxExploreBottomScreenControllerState
        > {
  final BxGetExploreTopicUsecase _getExploreTopicUsecase;
  final BxGetTopAgentsUsecase _getTopAgentsUsecase;
  final BxActiveTopBannerAdsUsecase _activeTopBannerAdsUsecase;
  final BxGetExploreTripsUsecase _getExploreTripsUsecase;

  BxExploreBottomScreenControllerBloc({
    required BxGetExploreTopicUsecase getExploreTopicUsecase,
    required BxGetTopAgentsUsecase getTopAgentsUsecase,
    required BxActiveTopBannerAdsUsecase activeTopBannerAdsUsecase,
    required BxGetExploreTripsUsecase getExploreTripsUsecase,
  }) : _getExploreTopicUsecase = getExploreTopicUsecase,
       _getTopAgentsUsecase = getTopAgentsUsecase,
       _activeTopBannerAdsUsecase = activeTopBannerAdsUsecase,
       _getExploreTripsUsecase = getExploreTripsUsecase,
       super(const BxExploreBottomScreenControllerState()) {
    on<BxLoadExploreContent>(_onLoadExploreContent);
  }

  Future<void> _onLoadExploreContent(
    BxLoadExploreContent event,
    Emitter<BxExploreBottomScreenControllerState> emit,
  ) async {
    emit(state.copyWith(status: BxExploreBottomScreenControllerStatus.loading));
    try {
      // Fetch all data in parallel
      final exploreTopicRequest = BxGetExploreTopicRequest(
        page: 1,
        pageSize: 20,
      );
      final topAgentsRequest = BxGetTopAgentRequest(limit: 10);
      final heroAdsRequest = BxActiveTopBannerAdsRequest(page: 1, pageSize: 10);
      final exploreTripsRequest = BxGetExploreTripsRequest(
        page: 1,
        pageSize: 10,
      );

      final results = await Future.wait([
        _getExploreTopicUsecase.execute(exploreTopicRequest),
        _getTopAgentsUsecase.execute(topAgentsRequest),
        _activeTopBannerAdsUsecase.execute(heroAdsRequest),
        _getExploreTripsUsecase.execute(exploreTripsRequest),
      ]);

      final exploreTopicResponse = results[0] as BxGetExploreTopicResponse;
      final topAgentsResponse = results[1] as BxGetTopAgentResponse;
      final heroAdsResponse = results[2] as BxActiveTopBannerAdsResponse;
      final exploreTripsResponse = results[3] as BxGetExploreTripsResponse;

      if (exploreTopicResponse.code == 0 && exploreTopicResponse.data != null) {
        emit(
          state.copyWith(
            status: BxExploreBottomScreenControllerStatus.success,
            exploreTopics: exploreTopicResponse.data!.list,
            topAgents: topAgentsResponse.data ?? [],
            heroAds: heroAdsResponse.data?.list ?? [],
            trendingTrips: exploreTripsResponse.data?.list ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(status: BxExploreBottomScreenControllerStatus.failure),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: BxExploreBottomScreenControllerStatus.failure),
      );
    }
  }
}
