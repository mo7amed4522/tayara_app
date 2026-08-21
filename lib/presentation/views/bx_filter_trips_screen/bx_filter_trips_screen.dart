// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_filter_trips_screen/bx_filter_trips_screen.dart
// Architecture: Presentation Layer - Filter Trips Screen
// Purpose: Screen that delegates to mobile/tablet filter widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_filter_trips_widget/bx_filter_trips_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_filter_trips_widget/bx_filter_trips_widget_tablet.dart';

class BxFilterTripsScreen extends StatelessWidget {
  const BxFilterTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxFilterTripsWidgetMobile(),
        tabletBuilder: (context) => const BxFilterTripsWidgetTablet(),
      ),
    );
  }
}
