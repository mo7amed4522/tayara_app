// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_on_boarding_screen/bx_on_boarding_screen.dart
// Architecture: Presentation Layer - Bx On Boarding Screen
// Purpose: Main bx on boarding screen that delegates to mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_on_boarding_widget/bx_on_boarding_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_on_boarding_widget/bx_on_boarding_widget_tablet.dart';

class BxOnBoardingScreen extends StatelessWidget {
  const BxOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxOnBoardingControllerBloc(
        sharedPreferencesDataSource: BxDependencyInjector.instance
            .get<BxSharedPreferencesDataSource>(),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return BxOnBoardingWidgetMobile();
          } else {
            return BxOnBoardingWidgetTablet();
          }
        },
      ),
    );
  }
}
