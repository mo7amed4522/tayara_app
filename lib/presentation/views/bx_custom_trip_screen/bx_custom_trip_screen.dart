// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_custom_trip_screen/bx_custom_trip_screen.dart
// Architecture: Presentation Layer - Custom Trip Screen
// Purpose: Screen that delegates to mobile/tablet custom trip planning widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_custom_trip_widget/bx_custom_trip_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_custom_trip_widget/bx_custom_trip_widget_tablet.dart';

class BxCustomTripScreen extends StatelessWidget {
  const BxCustomTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxCustomTripWidgetMobile(),
        tabletBuilder: (context) => const BxCustomTripWidgetTablet(),
      ),
    );
  }
}
