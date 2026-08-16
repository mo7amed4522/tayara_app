// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_event.dart
// Architecture: Presentation Layer - On Boarding Controller
// Purpose: Events for managing on boarding state and persistence

part of 'bx_on_boarding_controller_bloc.dart';

abstract class BxOnBoardingControllerEvent extends Equatable {
  const BxOnBoardingControllerEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the user swipes the PageView to a new page.
class BxOnBoardingPageChanged extends BxOnBoardingControllerEvent {
  final int page;

  const BxOnBoardingPageChanged(this.page);

  @override
  List<Object?> get props => [page];
}

/// Triggered when the Next/Get Started button is pressed.
class BxOnBoardingNextPage extends BxOnBoardingControllerEvent {}

/// Triggered when the user wants to skip onboarding.
class BxOnBoardingSkip extends BxOnBoardingControllerEvent {
  final BuildContext context;

  const BxOnBoardingSkip(this.context);

  @override
  List<Object?> get props => [context];
}
