// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_search_screen/bx_search_screen.dart
// Architecture: Presentation Layer - Search Screen
// Purpose: Screen that delegates to mobile/tablet search widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/domain/usecase/bx_custom_search_usecase.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_search_widget/bx_search_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_search_widget/bx_search_widget_tablet.dart';

class BxSearchScreen extends StatelessWidget {
  const BxSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the keyword from route arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final initialKeyword = arguments?['keyword'] as String? ?? '';

    return BlocProvider(
      create: (_) => BxSearchScreenControllerBloc(
        customSearchUsecase: BxDependencyInjector.instance
            .get<BxCustomSearchUsecase>(),
      )..add(const BxLoadSearch()),
      child: Scaffold(
        body: BxResponsiveBuilder(
          mobileBuilder: (context) =>
              BxSearchWidgetMobile(initialKeyword: initialKeyword),
          tabletBuilder: (context) =>
              BxSearchWidgetTablet(initialKeyword: initialKeyword),
        ),
      ),
    );
  }
}
