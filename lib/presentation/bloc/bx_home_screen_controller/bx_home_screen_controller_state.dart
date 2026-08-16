// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_state.dart
// Architecture: Presentation Layer - Home Screen Controller
// Purpose: BLoC for managing home screen tab state
part of 'bx_home_screen_controller_bloc.dart';

class BxHomeScreenControllerState extends Equatable {
  /// Index of the currently selected tab.
  final int selectedIndex;

  const BxHomeScreenControllerState({this.selectedIndex = 0});

  @override
  List<Object?> get props => [selectedIndex];

  BxHomeScreenControllerState copyWith({int? selectedIndex}) {
    return BxHomeScreenControllerState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
