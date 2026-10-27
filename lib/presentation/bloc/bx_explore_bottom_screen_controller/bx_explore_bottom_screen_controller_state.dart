// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Explore Bottom Screen Controller
// Purpose: State class for explore bottom screen BLoC
// ignore_for_file: prefer_initializing_formals

part of 'bx_explore_bottom_screen_controller_bloc.dart';

enum BxExploreBottomScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxExploreBottomScreenControllerState extends Equatable {
  final BxExploreBottomScreenControllerStatus status;
  final List<BxExploreTopic> exploreTopics;
  final List<BxGetTopAgent> topAgents;
  final List<BxActiveTopBannerAd> heroAds;
  final List<BxGetExploreTrip> trendingTrips;

  const BxExploreBottomScreenControllerState({
    this.status = BxExploreBottomScreenControllerStatus.initial,
    this.exploreTopics = const [],
    this.topAgents = const [],
    this.heroAds = const [],
    this.trendingTrips = const [],
  });

  BxExploreBottomScreenControllerState copyWith({
    BxExploreBottomScreenControllerStatus? status,
    List<BxExploreTopic>? exploreTopics,
    List<BxGetTopAgent>? topAgents,
    List<BxActiveTopBannerAd>? heroAds,
    List<BxGetExploreTrip>? trendingTrips,
  }) {
    return BxExploreBottomScreenControllerState(
      status: status ?? this.status,
      exploreTopics: exploreTopics ?? this.exploreTopics,
      topAgents: topAgents ?? this.topAgents,
      heroAds: heroAds ?? this.heroAds,
      trendingTrips: trendingTrips ?? this.trendingTrips,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exploreTopics,
    topAgents,
    heroAds,
    trendingTrips,
  ];
}
