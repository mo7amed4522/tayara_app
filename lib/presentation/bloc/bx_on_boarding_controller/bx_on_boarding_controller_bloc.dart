// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_bloc.dart
// Architecture: Presentation Layer - On Boarding Controller
// Purpose: BLoC for managing on boarding state and persistence

// ignore_for_file: use_build_context_synchronously, prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/constant/bx_shared_preferences_keys.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';

part 'bx_on_boarding_controller_event.dart';
part 'bx_on_boarding_controller_state.dart';

class BxOnBoardingControllerBloc
    extends Bloc<BxOnBoardingControllerEvent, BxOnBoardingControllerState> {
  final BxSharedPreferencesDataSource _sharedPreferencesDataSource;
  BxOnBoardingControllerBloc({
    required BxSharedPreferencesDataSource sharedPreferencesDataSource,
  }) : _sharedPreferencesDataSource = sharedPreferencesDataSource,
       super(
         BxOnBoardingControllerState(
           pages: [
             BxOnBoardingPage(
               title: 'Discover Trips Easily',
               description:
                   'Search and explore hundreds of destinations in seconds',
               imagePath: BxAppConstant.onBoarding1,
             ),
             BxOnBoardingPage(
               title: 'Choose Your Perfect Agency',
               description:
                   'Compare trusted agencies, ratings, and offers to find your best match.',
               imagePath: BxAppConstant.onBoarding2,
             ),
             BxOnBoardingPage(
               title: 'Plan Your Trip Day by Day',
               description:
                   'Customize itineraries with hotels, activities, and highlights.',
               imagePath: BxAppConstant.onBoarding3,
             ),
             BxOnBoardingPage(
               title: 'Book Securely in Seconds',
               description:
                   'Fast, safe, and reliable bookings all in one place.',
               imagePath: BxAppConstant.onBoarding4,
             ),
             BxOnBoardingPage(
               title: 'Let the Adventure Begin',
               description:
                   'Your journey starts here. Explore, book, and travel with ease.',
               imagePath: BxAppConstant.onBoarding5,
             ),
           ],
         ),
       ) {
    on<BxOnBoardingPageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.page));
    });

    on<BxOnBoardingNextPage>((event, emit) {
      if (state.currentPage < state.pages.length - 1) {
        emit(state.copyWith(currentPage: state.currentPage + 1));
      } else {
        emit(state.copyWith(status: BxOnBoardingControllerStatus.completed));
      }
    });

    on<BxOnBoardingSkip>((event, emit) async {
      await _sharedPreferencesDataSource.saveBool(
        BxSharedPreferencesKeys.onboardingCompleted,
        true,
      );
      BxAppRouter.pushReplacement(event.context, BxRouteNames.bxLoginScreen);
      emit(state.copyWith(status: BxOnBoardingControllerStatus.completed));
    });
  }
}
