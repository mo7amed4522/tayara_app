// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_agencies_screen/bx_agencies_screen.dart
// Architecture: Presentation Layer - Agencies Screen
// Purpose: Screen that delegates to mobile/tablet agencies list widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_agencies_widget/bx_agencies_widget_tablet.dart';

class BxAgenciesScreen extends StatelessWidget {
  const BxAgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxAgenciesWidgetMobile(),
        tabletBuilder: (context) => const BxAgenciesWidgetTablet(),
      ),
    );
  }
}
