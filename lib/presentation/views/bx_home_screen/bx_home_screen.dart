// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_home_screen/bx_home_screen.dart
// Architecture: Presentation Layer - Bx Home Screen
// Purpose: Main home screen that delegates to mobile/tablet widgets via BxResponsiveBuilder

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_home_widget/bx_home_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_home_widget/bx_home_widget_tablet.dart';

class BxHomeScreen extends StatelessWidget {
  const BxHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxHomeScreenControllerBloc(),
      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxHomeWidgetMobile(),
        tabletBuilder: (context) => const BxHomeWidgetTablet(),
      ),
    );
  }
}
