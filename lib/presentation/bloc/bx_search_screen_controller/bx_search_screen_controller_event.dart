// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_event.dart
// Architecture: Presentation Layer - Search Screen Controller
// Purpose: Events for search screen BLoC

part of 'bx_search_screen_controller_bloc.dart';

abstract class BxSearchScreenControllerEvent extends Equatable {
  const BxSearchScreenControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxLoadSearch extends BxSearchScreenControllerEvent {
  const BxLoadSearch();
}

class BxUpdateSearchQuery extends BxSearchScreenControllerEvent {
  final String query;
  const BxUpdateSearchQuery({required this.query});
  @override
  List<Object?> get props => [query];
}

class BxSearchCustom extends BxSearchScreenControllerEvent {
  final String keyword;
  final int page;
  final int pageSize;
  const BxSearchCustom({
    required this.keyword,
    this.page = 1,
    this.pageSize = 10,
  });
  @override
  List<Object?> get props => [keyword, page, pageSize];
}
