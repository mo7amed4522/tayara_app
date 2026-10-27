// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: State class for managing all home section states
// ignore_for_file: unintended_html_in_doc_comment, prefer_initializing_formals

part of 'bx_home_bottom_screen_controller_bloc.dart';

/// Status shared by every home section (ads, destinations, trips, etc.).
enum BxHomeBottomScreenControllerStatus { initial, loading, success, failure }

/// All home-section data is modelled using the actual response model types
/// so that widgets can access type-safe properties directly.
class BxHomeBottomScreenControllerState extends Equatable {
  final BxHomeBottomScreenControllerStatus status;

  /// Top banner ad carousel
  final List<BxActiveTopBannerAd> ads;
  final int adCurrentPage;

  /// Destinations grid
  final List<BxGetDestination> destinations;
  final int destinationsPage;
  final int destinationsTotalPage;

  /// Selected category filter for destinations (null = show all)
  final String? selectedCategory;

  /// Explore trips (for the "Explore" section and search fallback)
  final List<BxGetExploreTrip> exploreTrips;
  final int exploreTripsPage;
  final int exploreTripsTotalPage;

  /// Search results
  final List<BxSearchPackage> searchResults;
  final String searchKeyword;
  final int searchPage;
  final int searchTotalPage;

  /// Recommended for authenticated customer
  final List<BxRecommendedForCustomerPackage> recommended;
  final bool recommendedLoaded;

  /// Top Deals
  final List<BxGetTopDeal> topDeals;
  final bool topDealsLoaded;

  /// Top Agents
  final List<BxGetTopAgent> topAgents;
  final bool topAgentsLoaded;

  const BxHomeBottomScreenControllerState({
    this.status = BxHomeBottomScreenControllerStatus.initial,
    this.ads = const [],
    this.adCurrentPage = 0,
    this.destinations = const [],
    this.destinationsPage = 0,
    this.destinationsTotalPage = 0,
    this.selectedCategory,
    this.exploreTrips = const [],
    this.exploreTripsPage = 0,
    this.exploreTripsTotalPage = 0,
    this.searchResults = const [],
    this.searchKeyword = '',
    this.searchPage = 0,
    this.searchTotalPage = 0,
    this.recommended = const [],
    this.recommendedLoaded = false,
    this.topDeals = const [],
    this.topDealsLoaded = false,
    this.topAgents = const [],
    this.topAgentsLoaded = false,
  });

  /// Merge newly fetched page data with the existing collection.
  BxHomeBottomScreenControllerState copyWith({
    BxHomeBottomScreenControllerStatus? status,
    List<BxActiveTopBannerAd>? ads,
    int? adCurrentPage,
    List<BxGetDestination>? destinations,
    int? destinationsPage,
    int? destinationsTotalPage,
    String? selectedCategory,
    bool clearSelectedCategory = false,
    List<BxGetExploreTrip>? exploreTrips,
    int? exploreTripsPage,
    int? exploreTripsTotalPage,
    List<BxSearchPackage>? searchResults,
    String? searchKeyword,
    int? searchPage,
    int? searchTotalPage,
    List<BxRecommendedForCustomerPackage>? recommended,
    bool? recommendedLoaded,
    List<BxGetTopDeal>? topDeals,
    bool? topDealsLoaded,
    List<BxGetTopAgent>? topAgents,
    bool? topAgentsLoaded,
  }) {
    return BxHomeBottomScreenControllerState(
      status: status ?? this.status,
      ads: ads ?? this.ads,
      adCurrentPage: adCurrentPage ?? this.adCurrentPage,
      destinations: destinations ?? this.destinations,
      destinationsPage: destinationsPage ?? this.destinationsPage,
      destinationsTotalPage:
          destinationsTotalPage ?? this.destinationsTotalPage,
      selectedCategory: clearSelectedCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
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
      topDeals: topDeals ?? this.topDeals,
      topDealsLoaded: topDealsLoaded ?? this.topDealsLoaded,
      topAgents: topAgents ?? this.topAgents,
      topAgentsLoaded: topAgentsLoaded ?? this.topAgentsLoaded,
    );
  }

  @override
  List<Object?> get props => [
    status,
    ads,
    adCurrentPage,
    destinations,
    destinationsPage,
    destinationsTotalPage,
    selectedCategory,
    exploreTrips,
    exploreTripsPage,
    exploreTripsTotalPage,
    searchResults,
    searchKeyword,
    searchPage,
    searchTotalPage,
    recommended,
    recommendedLoaded,
    topDeals,
    topDealsLoaded,
    topAgents,
    topAgentsLoaded,
  ];
}
