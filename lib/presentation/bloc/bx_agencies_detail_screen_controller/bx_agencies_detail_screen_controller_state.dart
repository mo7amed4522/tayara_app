// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_agencies_detail_screen_controller/bx_agencies_detail_screen_controller_state.dart
// Architecture: Presentation Layer - Agencies Detail Screen Controller
// Purpose: State for the agencies detail screen

part of 'bx_agencies_detail_screen_controller_bloc.dart';

enum BxAgenciesDetailScreenControllerStatus {
  initial,
  loading,
  success,
  failure,
}

class BxAgenciesDetailScreenControllerState extends Equatable {
  final BxAgenciesDetailScreenControllerStatus status;
  final int agentId;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String selectedCategory; // 'All' by default
  final BxAgentProfileDetailsResponse? response;
  final String? errorMessage;

  const BxAgenciesDetailScreenControllerState({
    this.status = BxAgenciesDetailScreenControllerStatus.initial,
    this.agentId = 0,
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.selectedCategory = 'All',
    this.response,
    this.errorMessage,
  });

  // Convenience getters used by the UI layer
  BxAgentProfileAgent? get agent => response?.data?.agent;
  List<BxAgentProfilePackage> get packages =>
      response?.data?.packages ?? const [];
  List<BxAgentProfileReview> get reviews => response?.data?.reviews ?? const [];
  int get packagesTotal => response?.data?.packagesTotal ?? 0;
  int get reviewTotal => response?.data?.reviewTotal ?? 0;
  double? get reviewAvgRating => response?.data?.reviewAvgRating;
  String? get topDestination => response?.data?.topDestination;

  /// Packages filtered by [selectedCategory] (case-insensitive match on
  /// the package `category` field). "All" returns everything.
  List<BxAgentProfilePackage> get filteredPackages {
    if (selectedCategory == 'All' || selectedCategory.isEmpty) return packages;
    final target = selectedCategory.toLowerCase();
    return packages
        .where((p) => (p.category ?? '').toLowerCase() == target)
        .toList();
  }

  @override
  List<Object?> get props => [
    status,
    agentId,
    page,
    hasMore,
    isLoadingMore,
    selectedCategory,
    response,
    errorMessage,
  ];

  BxAgenciesDetailScreenControllerState copyWith({
    BxAgenciesDetailScreenControllerStatus? status,
    int? agentId,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? selectedCategory,
    BxAgentProfileDetailsResponse? response,
    String? errorMessage,
  }) {
    return BxAgenciesDetailScreenControllerState(
      status: status ?? this.status,
      agentId: agentId ?? this.agentId,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
