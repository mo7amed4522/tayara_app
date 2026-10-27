// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_agencies_detail_screen_controller/bx_agencies_detail_screen_controller_event.dart
// Architecture: Presentation Layer - Agencies Detail Screen Controller
// Purpose: Events for the agencies detail screen BLoC

part of 'bx_agencies_detail_screen_controller_bloc.dart';

abstract class BxAgenciesDetailScreenControllerEvent extends Equatable {
  const BxAgenciesDetailScreenControllerEvent();
  @override
  List<Object?> get props => [];
}

/// Fired once when the screen is first built — fetches the agent profile
/// (agent info + first page of packages + reviews).
class BxLoadAgentProfileDetails extends BxAgenciesDetailScreenControllerEvent {
  final int agentId;
  final int pageSize;
  const BxLoadAgentProfileDetails({required this.agentId, this.pageSize = 10});
  @override
  List<Object?> get props => [agentId, pageSize];
}

/// Appends the next page of packages to the existing list.
class BxLoadMoreAgentPackages extends BxAgenciesDetailScreenControllerEvent {
  final int pageSize;
  const BxLoadMoreAgentPackages({this.pageSize = 10});
  @override
  List<Object?> get props => [pageSize];
}

/// Filters the visible packages by category tab ("All", "Cruises", …).
class BxChangePackageFilter extends BxAgenciesDetailScreenControllerEvent {
  final String category;
  const BxChangePackageFilter({required this.category});
  @override
  List<Object?> get props => [category];
}
