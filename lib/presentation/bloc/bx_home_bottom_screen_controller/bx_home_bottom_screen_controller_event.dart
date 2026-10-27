// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_event.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: Events for home bottom screen BLoC (load + pagination)
// ignore_for_file: prefer_initializing_formals

part of 'bx_home_bottom_screen_controller_bloc.dart';

abstract class BxHomeBottomScreenControllerEvent extends Equatable {
  const BxHomeBottomScreenControllerEvent();

  @override
  List<Object> get props => [];
}

/// Triggers initial fetch of all home sections (ads, destinations,
/// explore trips, recommended).
class BxLoadHomeContentEvent extends BxHomeBottomScreenControllerEvent {
  const BxLoadHomeContentEvent();
}

/// Ad carousel pagination.
class BxAdPageChanged extends BxHomeBottomScreenControllerEvent {
  final int pageIndex;

  const BxAdPageChanged({required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}

/// Load / append destinations (paginated).
class BxLoadDestinationsEvent extends BxHomeBottomScreenControllerEvent {
  final int page;
  final int pageSize;

  const BxLoadDestinationsEvent({required this.page, required this.pageSize});

  @override
  List<Object> get props => [page, pageSize];
}

/// Load / append explore trips (paginated).
class BxLoadExploreTripsEvent extends BxHomeBottomScreenControllerEvent {
  final int page;
  final int pageSize;
  final String? category;

  const BxLoadExploreTripsEvent({
    required this.page,
    required this.pageSize,
    this.category,
  });

  @override
  List<Object> get props => [page, pageSize, category ?? ''];
}

/// Trigger a search (paginated).
class BxSearchEvent extends BxHomeBottomScreenControllerEvent {
  final String keyword;
  final int page;
  final int pageSize;

  const BxSearchEvent({
    required this.keyword,
    required this.page,
    required this.pageSize,
  });

  @override
  List<Object> get props => [keyword, page, pageSize];
}

/// Load recommended for the authenticated customer.
class BxLoadRecommendedEvent extends BxHomeBottomScreenControllerEvent {
  final int limit;

  const BxLoadRecommendedEvent({required this.limit});

  @override
  List<Object> get props => [limit];
}

/// Select a destination category to filter the Discover Destinations grid.
class BxCategorySelectedEvent extends BxHomeBottomScreenControllerEvent {
  final String category;

  const BxCategorySelectedEvent({required this.category});

  @override
  List<Object> get props => [category];
}

/// Load top deals (paginated).
class BxLoadTopDealsEvent extends BxHomeBottomScreenControllerEvent {
  final int page;
  final int pageSize;

  const BxLoadTopDealsEvent({required this.page, required this.pageSize});

  @override
  List<Object> get props => [page, pageSize];
}

/// Load top agents.
class BxLoadTopAgentsEvent extends BxHomeBottomScreenControllerEvent {
  final int limit;

  const BxLoadTopAgentsEvent({required this.limit});

  @override
  List<Object> get props => [limit];
}