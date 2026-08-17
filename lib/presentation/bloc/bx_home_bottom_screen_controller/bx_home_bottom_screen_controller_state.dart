// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_state.dart
// Architecture: Presentation Layer - Home Bottom Screen Controller
// Purpose: State class for managing the state of the home bottom screen
// ignore_for_file: prefer_initializing_formals
part of 'bx_home_bottom_screen_controller_bloc.dart';

enum BxHomeBottomScreenControllerStatus { initial, loading, success, failure }

class BxHomeBottomScreenControllerState extends Equatable {
  final BxHomeBottomScreenControllerStatus status;
  final List<Map<String, String>> ads;
  final int currentPage;

  const BxHomeBottomScreenControllerState({
    this.status = BxHomeBottomScreenControllerStatus.initial,
    this.ads = const [],
    this.currentPage = 0,
  });

  BxHomeBottomScreenControllerState copyWith({
    int? selectedIndex,
    BxHomeBottomScreenControllerStatus? status,
    List<Map<String, String>>? ads,
    int? currentPage,
  }) {
    return BxHomeBottomScreenControllerState(
      status: status ?? this.status,
      ads: ads ?? this.ads,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [status, ads, currentPage];
}
