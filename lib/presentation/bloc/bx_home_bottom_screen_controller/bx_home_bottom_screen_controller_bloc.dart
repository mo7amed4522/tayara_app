// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: BLoC managing home bottom screen tab navigation and ad carousel state
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tayara/domain/model/request/bx_active_top_banner_ads_request.dart';
import 'package:tayara/domain/model/request/bx_get_destinations_request.dart';
import 'package:tayara/domain/model/request/bx_get_explore_trips_request.dart';
import 'package:tayara/domain/model/request/bx_get_recommended_for_customer_request.dart';
import 'package:tayara/domain/model/request/bx_get_search_request.dart';
import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/request/bx_get_top_deals_request.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_deals_response.dart';
import 'package:tayara/domain/usecase/bx_active_top_banner_ads_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_destinations_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_trips_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_recommended_for_customer_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_search_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_agent_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_deals_usecase.dart';

part 'bx_home_bottom_screen_controller_state.dart';
part 'bx_home_bottom_screen_controller_event.dart';

class BxHomeBottomScreenControllerBloc
    extends
        Bloc<
          BxHomeBottomScreenControllerEvent,
          BxHomeBottomScreenControllerState
        > {
  final BxActiveTopBannerAdsUsecase _adsUsecase;
  final BxGetDestinationsUsecase _destinationsUsecase;
  final BxGetExploreTripsUsecase _exploreTripsUsecase;
  final BxGetRecommendedForCustomerUsecase _recommendedUsecase;
  final BxGetSearchUsecase _searchUsecase;
  final BxGetTopDealsUsecase _topDealsUsecase;
  final BxGetTopAgentsUsecase _topAgentsUsecase;

  static const int _pageSize = 10;

  BxHomeBottomScreenControllerBloc({
    required BxActiveTopBannerAdsUsecase adsUsecase,
    required BxGetDestinationsUsecase destinationsUsecase,
    required BxGetExploreTripsUsecase exploreTripsUsecase,
    required BxGetRecommendedForCustomerUsecase recommendedUsecase,
    required BxGetSearchUsecase searchUsecase,
    required BxGetTopDealsUsecase topDealsUsecase,
    required BxGetTopAgentsUsecase topAgentsUsecase,
  }) : _adsUsecase = adsUsecase,
       _destinationsUsecase = destinationsUsecase,
       _exploreTripsUsecase = exploreTripsUsecase,
       _recommendedUsecase = recommendedUsecase,
       _searchUsecase = searchUsecase,
       _topDealsUsecase = topDealsUsecase,
       _topAgentsUsecase = topAgentsUsecase,
       super(const BxHomeBottomScreenControllerState()) {
    on<BxLoadHomeContentEvent>(_onLoadHomeContent);
    on<BxLoadDestinationsEvent>(_onLoadDestinations);
    on<BxLoadExploreTripsEvent>(_onLoadExploreTrips);
    on<BxSearchEvent>(_onSearch);
    on<BxLoadRecommendedEvent>(_onLoadRecommended);
    on<BxAdPageChanged>(_onAdPageChanged);
    on<BxCategorySelectedEvent>(_onCategorySelected);
    on<BxLoadTopDealsEvent>(_onLoadTopDeals);
    on<BxLoadTopAgentsEvent>(_onLoadTopAgents);
  }

  Future<void> _onLoadHomeContent(
    BxLoadHomeContentEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    // Load all sections in parallel (ads, destinations, explore trips, recommended, top deals, top agents)
    emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.loading));

    try {
      // Fetch all in parallel
      final adsRequest = BxActiveTopBannerAdsRequest(
        page: 1,
        pageSize: _pageSize,
      );
      final destinationsRequest = BxGetDestinationsRequest(
        page: 1,
        pageSize: _pageSize,
      );
      final exploreTripsRequest = BxGetExploreTripsRequest(
        page: 1,
        pageSize: _pageSize,
      );
      final recommendedRequest = BxGetRecommendedForCustomerRequest(
        limit: _pageSize,
      );
      final topDealsRequest = BxGetTopDealsRequest(
        page: 1,
        pageSize: _pageSize,
      );
      final topAgentsRequest = BxGetTopAgentRequest(limit: _pageSize);

      final results = await Future.wait([
        _adsUsecase.execute(adsRequest),
        _destinationsUsecase.execute(destinationsRequest),
        _exploreTripsUsecase.execute(exploreTripsRequest),
        _recommendedUsecase.execute(recommendedRequest),
        _topDealsUsecase.execute(topDealsRequest),
        _topAgentsUsecase.execute(topAgentsRequest),
      ]);

      final adsResponse = results[0] as BxActiveTopBannerAdsResponse;
      final destinationsResponse = results[1] as BxGetDestinationsResponse;
      final exploreTripsResponse = results[2] as BxGetExploreTripsResponse;
      final recommendedResponse =
          results[3] as BxGetRecommendedForCustomerResponse;
      final topDealsResponse = results[4] as BxGetTopDealsResponse;
      final topAgentsResponse = results[5] as BxGetTopAgentResponse;

      // Store response models directly in state
      final ads = adsResponse.data?.list ?? [];
      final destinations = destinationsResponse.data?.list ?? [];
      final exploreTrips = exploreTripsResponse.data?.list ?? [];
      final topDeals = topDealsResponse.data?.list ?? [];
      final topAgents = topAgentsResponse.data ?? [];

      // Handle unauthorized for recommended
      final bool unauthorized = recommendedResponse.code == _unauthorizedCode;
      final recommended = unauthorized
          ? <BxRecommendedForCustomerPackage>[]
          : recommendedResponse.data ?? [];

      emit(
        state.copyWith(
          status: BxHomeBottomScreenControllerStatus.success,
          ads: ads,
          adCurrentPage: 1,
          destinations: destinations,
          destinationsPage: 1,
          destinationsTotalPage: destinationsResponse.data?.totalPage ?? 0,
          exploreTrips: exploreTrips,
          exploreTripsPage: 1,
          exploreTripsTotalPage: exploreTripsResponse.data?.totalPage ?? 0,
          recommended: recommended,
          recommendedLoaded: !unauthorized,
          topDeals: topDeals,
          topDealsLoaded: true,
          topAgents: topAgents,
          topAgentsLoaded: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BxHomeBottomScreenControllerStatus.failure));
    }
  }

  Future<void> _onLoadDestinations(
    BxLoadDestinationsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    if (state.status == BxHomeBottomScreenControllerStatus.failure) return;

    try {
      final request = BxGetDestinationsRequest(
        page: event.page,
        pageSize: event.pageSize,
      );
      final response = await _destinationsUsecase.execute(request);

      final newItems = response.data?.list ?? [];
      final allItems = (event.page == 1)
          ? newItems
          : [...state.destinations, ...newItems];

      emit(
        state.copyWith(
          destinations: allItems,
          destinationsPage: event.page,
          destinationsTotalPage: response.data?.totalPage ?? 0,
        ),
      );
    } catch (_) {
      // Keep current state on error
    }
  }

  Future<void> _onLoadExploreTrips(
    BxLoadExploreTripsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    if (state.status == BxHomeBottomScreenControllerStatus.failure) return;

    try {
      final request = BxGetExploreTripsRequest(
        page: event.page,
        pageSize: event.pageSize,
        category: event.category,
      );
      final response = await _exploreTripsUsecase.execute(request);

      final newItems = response.data?.list ?? [];
      final allItems = (event.page == 1)
          ? newItems
          : [...state.exploreTrips, ...newItems];

      emit(
        state.copyWith(
          exploreTrips: allItems,
          exploreTripsPage: event.page,
          exploreTripsTotalPage: response.data?.totalPage ?? 0,
        ),
      );
    } catch (_) {
      // Keep current state on error
    }
  }

  Future<void> _onSearch(
    BxSearchEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    if (state.status == BxHomeBottomScreenControllerStatus.failure) return;

    try {
      final request = BxGetSearchRequest(
        keyword: event.keyword,
        page: event.page,
        pageSize: event.pageSize,
      );
      final response = await _searchUsecase.execute(request);

      // Search returns agents and packages - we'll show packages in the search results
      final newItems = response.data?.packages ?? [];
      final allItems = (event.page == 1)
          ? newItems
          : [...state.searchResults, ...newItems];

      emit(
        state.copyWith(
          searchResults: allItems,
          searchKeyword: event.keyword,
          searchPage: event.page,
          searchTotalPage: 0,
        ),
      );
    } catch (_) {
      // Keep current state on error
    }
  }

  /// Response code returned by the backend when the customer is not
  /// logged in or the auth token is invalid/missing.
  static const int _unauthorizedCode = 1001;

  Future<void> _onLoadRecommended(
    BxLoadRecommendedEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    if (state.status == BxHomeBottomScreenControllerStatus.failure) return;

    try {
      final request = BxGetRecommendedForCustomerRequest(limit: event.limit);
      final response = await _recommendedUsecase.execute(request);

      // Authenticated endpoint: 401 (code 1001) means the user is not
      // logged in. Hide the section entirely rather than showing a stub.
      final bool unauthorized = response.code == _unauthorizedCode;

      final newItems = unauthorized
          ? <BxRecommendedForCustomerPackage>[]
          : response.data ?? [];

      emit(
        state.copyWith(recommended: newItems, recommendedLoaded: !unauthorized),
      );
    } catch (_) {
      // Keep current state on error
    }
  }

  void _onAdPageChanged(
    BxAdPageChanged event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) {
    emit(state.copyWith(adCurrentPage: event.pageIndex));
  }

  /// Handle category selection - filter destinations by selected category
  Future<void> _onCategorySelected(
    BxCategorySelectedEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    final category = event.category;

    // If same category is selected again, clear the filter
    if (state.selectedCategory == category) {
      emit(state.copyWith(selectedCategory: null, clearSelectedCategory: true));
      return;
    }

    // Load destinations filtered by category
    // For now, we'll filter locally since the API might not support category filtering
    // The API call can be enhanced later if needed
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> _onLoadTopDeals(
    BxLoadTopDealsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    try {
      final request = BxGetTopDealsRequest(
        page: event.page,
        pageSize: event.pageSize,
      );
      final response = await _topDealsUsecase.execute(request);

      final newItems = response.data?.list ?? [];
      final allItems = (event.page == 1)
          ? newItems
          : [...state.topDeals, ...newItems];

      emit(state.copyWith(topDeals: allItems, topDealsLoaded: true));
    } catch (_) {
      // Keep current state on error
    }
  }

  Future<void> _onLoadTopAgents(
    BxLoadTopAgentsEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    try {
      final request = BxGetTopAgentRequest(limit: event.limit);
      final response = await _topAgentsUsecase.execute(request);

      final newItems = response.data ?? [];
      final allItems =
          (event.limit == 10) // first load
          ? newItems
          : [...state.topAgents, ...newItems];

      emit(state.copyWith(topAgents: allItems, topAgentsLoaded: true));
    } catch (_) {
      // Keep current state on error
    }
  }
}
