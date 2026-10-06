// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: State class for managing all home section states
// ignore_for_file: unintended_html_in_doc_comment, prefer_initializing_formals

part of 'bx_home_bottom_screen_controller_bloc.dart';

/// Status shared by every home section (ads, destinations, trips, etc.).
enum BxHomeBottomScreenControllerStatus { initial, loading, success, failure }

/// All home-section data is modelled as [List<Map<String, dynamic>>> so that
/// [Map]-based widgets ([_DestinationGrid], [_TopDealCard], etc.) continue to
/// consume the data without changes. Each map holds the keys those widgets
/// already reference (image/name/price, coverImageUrl/name/price, etc.).
class BxHomeBottomScreenControllerState extends Equatable {
  final BxHomeBottomScreenControllerStatus status;

  /// Top banner ad carousel
  final List<Map<String, String>> ads;
  final int adCurrentPage;

  /// Destinations grid
  final List<Map<String, String>> destinations;
  final int destinationsPage;
  final int destinationsTotalPage;

  /// Explore trips (for the "Explore" section and search fallback)
  final List<Map<String, String>> exploreTrips;
  final int exploreTripsPage;
  final int exploreTripsTotalPage;

  /// Search results
  final List<Map<String, String>> searchResults;
  final String searchKeyword;
  final int searchPage;
  final int searchTotalPage;

  /// Recommended for authenticated customer
  final List<Map<String, String>> recommended;
  final bool recommendedLoaded;

  const BxHomeBottomScreenControllerState({
    this.status = BxHomeBottomScreenControllerStatus.initial,
    this.ads = const [],
    this.adCurrentPage = 0,
    this.destinations = const [],
    this.destinationsPage = 0,
    this.destinationsTotalPage = 0,
    this.exploreTrips = const [],
    this.exploreTripsPage = 0,
    this.exploreTripsTotalPage = 0,
    this.searchResults = const [],
    this.searchKeyword = '',
    this.searchPage = 0,
    this.searchTotalPage = 0,
    this.recommended = const [],
    this.recommendedLoaded = false,
  });

  /// Merge newly fetched page data with the existing collection.
  BxHomeBottomScreenControllerState copyWith({
    BxHomeBottomScreenControllerStatus? status,
    List<Map<String, String>>? ads,
    int? adCurrentPage,
    List<Map<String, String>>? destinations,
    int? destinationsPage,
    int? destinationsTotalPage,
    List<Map<String, String>>? exploreTrips,
    int? exploreTripsPage,
    int? exploreTripsTotalPage,
    List<Map<String, String>>? searchResults,
    String? searchKeyword,
    int? searchPage,
    int? searchTotalPage,
    List<Map<String, String>>? recommended,
    bool? recommendedLoaded,
  }) {
    return BxHomeBottomScreenControllerState(
      status: status ?? this.status,
      ads: ads ?? this.ads,
      adCurrentPage: adCurrentPage ?? this.adCurrentPage,
      destinations: destinations ?? this.destinations,
      destinationsPage: destinationsPage ?? this.destinationsPage,
      destinationsTotalPage:
          destinationsTotalPage ?? this.destinationsTotalPage,
      exploreTrips: exploreTrips ?? this.exploreTrips,
      exploreTripsPage: exploreTripsPage ?? this.exploreTripsPage,
      exploreTripsTotalPage:
          exploreTripsTotalPage ?? this.exploreTripsTotalPage,
      searchResults: searchResults ?? this.searchResults,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      searchPage: searchPage ?? this.searchPage,
      searchTotalPage: searchTotalPage ?? this.searchTotalPage,
      recommended: recommended ?? this.recommended,
      recommendedLoaded: recommendedLoaded ?? this.recommendedLoaded,
    );
  }

  @override
  List<Object> get props => [
    status,
    ads,
    adCurrentPage,
    destinations,
    destinationsPage,
    destinationsTotalPage,
    exploreTrips,
    exploreTripsPage,
    exploreTripsTotalPage,
    searchResults,
    searchKeyword,
    searchPage,
    searchTotalPage,
    recommended,
    recommendedLoaded,
  ];
}
