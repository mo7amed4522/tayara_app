// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_state.dart
// Architecture: Presentation Layer - On Boarding Controller
// Purpose: State management for on boarding functionality

part of 'bx_on_boarding_controller_bloc.dart';

enum BxOnBoardingControllerStatus { initial, loading, completed }

/// Represents a single onboarding page.
class BxOnBoardingPage {
  final String title;
  final String description;
  final String imagePath;

  const BxOnBoardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class BxOnBoardingControllerState extends Equatable {
  final BxOnBoardingControllerStatus status;
  final String? errorMessage;
  final List<BxOnBoardingPage> pages;
  final int currentPage;

  const BxOnBoardingControllerState({
    this.status = BxOnBoardingControllerStatus.initial,
    this.errorMessage,
    this.pages = const [],
    this.currentPage = 0,
  });

  @override
  List<Object?> get props => [status, errorMessage, pages, currentPage];

  BxOnBoardingControllerState copyWith({
    BxOnBoardingControllerStatus? status,
    String? errorMessage,
    List<BxOnBoardingPage>? pages,
    int? currentPage,
  }) {
    return BxOnBoardingControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pages: pages ?? this.pages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
