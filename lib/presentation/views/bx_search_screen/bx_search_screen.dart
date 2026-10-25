// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_search_screen/bx_search_screen.dart
// Architecture: Presentation Layer - Search Screen
// Purpose: Screen that delegates to mobile/tablet search widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_search_widget/bx_search_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_search_widget/bx_search_widget_tablet.dart';

class BxSearchScreen extends StatelessWidget {
  const BxSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxSearchWidgetMobile(),
        tabletBuilder: (context) => const BxSearchWidgetTablet(),
      ),
    );
  }
}
