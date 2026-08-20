// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_similar_trips_screen/bx_similar_trips_screen.dart
// Architecture: Presentation Layer - Similar Trips Screen
// Purpose: Screen that delegates to mobile/tablet similar trips widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_similar_trips_widget/bx_similar_trips_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_similar_trips_widget/bx_similar_trips_widget_tablet.dart';

class BxSimilarTripsScreen extends StatelessWidget {
  const BxSimilarTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxSimilarTripsWidgetMobile(),
        tabletBuilder: (context) => const BxSimilarTripsWidgetTablet(),
      ),
    );
  }
}
