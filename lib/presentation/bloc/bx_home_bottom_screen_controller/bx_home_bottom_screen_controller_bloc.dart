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
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/model/response/bx_get_search_response.dart';
import 'package:tayara/domain/usecase/bx_active_top_banner_ads_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_destinations_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_trips_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_recommended_for_customer_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_search_usecase.dart';

part 'bx_home_bottom_screen_controller_state.dart';
part 'bx_home_bottom_screen_controller_event.dart';

class BxHomeBottomScreenControllerBloc
    extends
        Bloc<BxHomeBottomScreenControllerEvent,
            BxHomeBottomScreenControllerState> {
  final BxActiveTopBannerAdsUsecase _adsUsecase;
  final BxGetDestinationsUsecase _destinationsUsecase;
  final BxGetExploreTripsUsecase _exploreTripsUsecase;
  final BxGetRecommendedForCustomerUsecase _recommendedUsecase;
  final BxGetSearchUsecase _searchUsecase;

  static const int _pageSize = 10;

  BxHomeBottomScreenControllerBloc({
    required BxActiveTopBannerAdsUsecase adsUsecase,
    required BxGetDestinationsUsecase destinationsUsecase,
    required BxGetExploreTripsUsecase exploreTripsUsecase,
    required BxGetRecommendedForCustomerUsecase recommendedUsecase,
    required BxGetSearchUsecase searchUsecase,
  })  : _adsUsecase = adsUsecase,
        _destinationsUsecase = destinationsUsecase,
        _exploreTripsUsecase = exploreTripsUsecase,
        _recommendedUsecase = recommendedUsecase,
        _searchUsecase = searchUsecase,
        super(const BxHomeBottomScreenControllerState()) {
    on<BxLoadHomeContentEvent>(_onLoadHomeContent);
    on<BxLoadDestinationsEvent>(_onLoadDestinations);
    on<BxLoadExploreTripsEvent>(_onLoadExploreTrips);
    on<BxSearchEvent>(_onSearch);
    on<BxLoadRecommendedEvent>(_onLoadRecommended);
    on<BxAdPageChanged>(_onAdPageChanged);
  }

  Future<void> _onLoadHomeContent(
    BxLoadHomeContentEvent event,
    Emitter<BxHomeBottomScreenControllerState> emit,
  ) async {
    // Load all sections in parallel (ads, destinations, explore trips, recommended)
    emit(state.copyWith(
      status: BxHomeBottomScreenControllerStatus.loading,
    ));

    try {
      // Fetch ads (page 1)
      final adsRequest = BxActiveTopBannerAdsRequest(page: 1, pageSize: _pageSize);
      final adsResponse = await _adsUsecase.execute(adsRequest);

      // Fetch destinations (page 1)
      final destinationsRequest =
          BxGetDestinationsRequest(page: 1, pageSize: _pageSize);
      final destinationsResponse =
          await _destinationsUsecase.execute(destinationsRequest);

      // Fetch explore trips (page 1)
      final exploreTripsRequest =
          BxGetExploreTripsRequest(page: 1, pageSize: _pageSize);
      final exploreTripsResponse =
          await _exploreTripsUsecase.execute(exploreTripsRequest);

      // Fetch recommended (limit 10) - only if user is authenticated
      // For now we always fetch; auth check can be added later if needed
      final recommendedRequest =
          BxGetRecommendedForCustomerRequest(limit: _pageSize);
      final recommendedResponse =
          await _recommendedUsecase.execute(recommendedRequest);

      // Convert responses to List<Map<String, String>>
      final ads = _convertAdsToMapList(adsResponse);
      final destinations =
          _convertDestinationsToMapList(destinationsResponse);
      final exploreTrips =
          _convertExploreTripsToMapList(exploreTripsResponse);
      final recommended =
          _convertRecommendedToMapList(recommendedResponse);

      emit(state.copyWith(
        status: BxHomeBottomScreenControllerStatus.success,
        ads: ads,
        adCurrentPage: 1,
        destinations: destinations,
        destinationsPage: 1,
        destinationsTotalPage: destinationsResponse.data?.totalPage ?? 0,
        exploreTrips: exploreTrips,
        exploreTripsPage: 1,
        exploreTripsTotalPage:
            exploreTripsResponse.data?.totalPage ?? 0,
        recommended: recommended,
        recommendedLoaded: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BxHomeBottomScreenControllerStatus.failure,
      ));
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

      final newItems =
          _convertDestinationsToMapList(response);
      final allItems = (event.page == 1)
          ? newItems
          : [...state.destinations, ...newItems];

      emit(state.copyWith(
        destinations: allItems,
        destinationsPage: event.page,
        destinationsTotalPage: response.data?.totalPage ?? 0,
      ));
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

      final newItems =
          _convertExploreTripsToMapList(response);
      final allItems = (event.page == 1)
          ? newItems
          : [...state.exploreTrips, ...newItems];

      emit(state.copyWith(
        exploreTrips: allItems,
        exploreTripsPage: event.page,
        exploreTripsTotalPage: response.data?.totalPage ?? 0,
      ));
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

      final newItems = _convertSearchToMapList(response);
      final allItems = (event.page == 1)
          ? newItems
          : [...state.searchResults, ...newItems];

      emit(state.copyWith(
        searchResults: allItems,
        searchKeyword: event.keyword,
        searchPage: event.page,
        searchTotalPage: 0,
      ));
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
      final request =
          BxGetRecommendedForCustomerRequest(limit: event.limit);
      final response = await _recommendedUsecase.execute(request);

      // Authenticated endpoint: 401 (code 1001) means the user is not
      // logged in. Hide the section entirely rather than showing a stub.
      final bool unauthorized = response.code == _unauthorizedCode;

      final newItems =
          unauthorized ? <Map<String, String>>[] : _convertRecommendedToMapList(response);

      emit(state.copyWith(
        recommended: newItems,
        recommendedLoaded: !unauthorized,
      ));
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

  // ----- Conversion helpers -----

  List<Map<String, String>> _convertAdsToMapList(
      BxActiveTopBannerAdsResponse response) {
    final list = response.data?.list ?? [];
    return list.map((ad) {
      return {
        'id': ad.id?.toString() ?? '',
        'imageUrl': ad.bannerImageUrl ?? '',
        'title': ad.overlayTitle ?? '',
        'subtitle': ad.overlaySubtitle ?? '',
        'buttonText': ad.ctaLabel ?? 'Explore Now',
      };
    }).toList();
  }

  List<Map<String, String>> _convertDestinationsToMapList(
      BxGetDestinationsResponse response) {
    final list = response.data?.list ?? [];
    return list.map((destination) {
      return {
        'id': destination.id?.toString() ?? '',
        'name': destination.name ?? '',
        'imageUrl': destination.imageUrl ?? '',
        // The destination widget expects 'price' and 'description' keys
        'price': '', // Not provided in destination model, using empty string
        'description': destination.description ?? '',
      };
    }).toList();
  }

  List<Map<String, String>> _convertExploreTripsToMapList(
      BxGetExploreTripsResponse response) {
    final list = response.data?.list ?? [];
    return list.map((trip) {
      return {
        'id': trip.id?.toString() ?? '',
        'name': trip.name ?? '',
        'imageUrl': trip.coverImageUrl ?? '',
        'price': trip.displayPrice?.toString() ?? '',
        'rating': trip.rating?.toString() ?? '0',
        'reviewCount': trip.reviewCount?.toString() ?? '0',
        'category': trip.category ?? '',
        'daysDuration': trip.daysDuration?.toString() ?? '',
        'discountPercent': trip.discountPercent?.toString() ?? '0',
      };
    }).toList();
  }

  List<Map<String, String>> _convertSearchToMapList(
      BxGetSearchResponse response) {
    // Search returns agents and packages - we'll show packages in the search results
    final packages = response.data?.packages ?? [];
    return packages.map((package) {
      return {
        'id': package.id?.toString() ?? '',
        'name': package.name ?? '',
        'imageUrl': package.coverImageUrl ?? '',
        'price': package.displayPrice?.toString() ?? '',
        'rating': package.rating?.toString() ?? '0',
        'reviewCount': package.reviewCount?.toString() ?? '0',
        'category': package.category ?? '',
        'daysDuration': package.daysDuration?.toString() ?? '',
        'discountPercent': package.discountPercent?.toString() ?? '0',
      };
    }).toList();
  }

  List<Map<String, String>> _convertRecommendedToMapList(
      BxGetRecommendedForCustomerResponse response) {
    final list = response.data ?? [];
    return list.map((item) {
      return {
        'id': item.id?.toString() ?? '',
        'name': item.name ?? '',
        'imageUrl': item.coverImageUrl ?? '',
        'price': item.displayPrice?.toString() ?? '',
        'rating': item.rating?.toString() ?? '0',
        'reviewCount': item.reviewCount?.toString() ?? '0',
        'category': item.category ?? '',
        'daysDuration': item.daysDuration?.toString() ?? '',
        'discountPercent': item.discountPercent?.toString() ?? '0',
      };
    }).toList();
  }
}