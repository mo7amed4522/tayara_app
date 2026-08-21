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
  final List<Map<String, String>> destinations;
  final List<Map<String, String>> trendingTrips;
  final List<Map<String, String>> themes;
  final List<Map<String, String>> heroAds;

  const BxExploreBottomScreenControllerState({
    this.status = BxExploreBottomScreenControllerStatus.initial,
    this.destinations = const [],
    this.trendingTrips = const [],
    this.themes = const [],
    this.heroAds = const [],
  });

  BxExploreBottomScreenControllerState copyWith({
    BxExploreBottomScreenControllerStatus? status,
    List<Map<String, String>>? destinations,
    List<Map<String, String>>? trendingTrips,
    List<Map<String, String>>? themes,
    List<Map<String, String>>? heroAds,
  }) {
    return BxExploreBottomScreenControllerState(
      status: status ?? this.status,
      destinations: destinations ?? this.destinations,
      trendingTrips: trendingTrips ?? this.trendingTrips,
      themes: themes ?? this.themes,
      heroAds: heroAds ?? this.heroAds,
    );
  }

  @override
  List<Object?> get props => [
    status,
    destinations,
    trendingTrips,
    themes,
    heroAds,
  ];
}
