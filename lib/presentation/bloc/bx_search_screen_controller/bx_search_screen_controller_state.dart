// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_search_controller/bx_search_controller_state.dart
// Architecture: Presentation Layer - Search Screen Controller
// Purpose: State management for the search screen
// ignore_for_file: prefer_initializing_formals, use_build_context_synchronously
part of 'bx_search_screen_controller_bloc.dart';

enum BxSearchScreenControllerStatus { initial, loading, success, failure }

class BxSearchScreenControllerState extends Equatable {
  final BxSearchScreenControllerStatus status;
  final String query;

  const BxSearchScreenControllerState({
    this.status = BxSearchScreenControllerStatus.initial,
    this.query = '',
  });

  @override
  List<Object?> get props => [status, query];

  BxSearchScreenControllerState copyWith({
    BxSearchScreenControllerStatus? status,
    String? query,
  }) {
    return BxSearchScreenControllerState(
      status: status ?? this.status,
      query: query ?? this.query,
    );
  }
}
