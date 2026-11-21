// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_login_screen/bx_login_screen.dart
// Architecture: Presentation Layer - Bx Login Screen
// Purpose: Main login screen that delegates to mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_login_controller/bx_login_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_login_widget/bx_login_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_login_widget/bx_login_widget_tablet.dart';

class BxLoginScreen extends StatelessWidget {
  const BxLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxLoginControllerBloc(
        useCase: BxDependencyInjector.instance.get<BxFirebaseLoginUsecase>(),
        sharedPreferencesDataSource: BxDependencyInjector.instance
            .get<BxSharedPreferencesDataSource>(),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const BxLoginWidgetMobile();
          } else {
            return const BxLoginWidgetTablet();
          }
        },
      ),
    );
  }
}
