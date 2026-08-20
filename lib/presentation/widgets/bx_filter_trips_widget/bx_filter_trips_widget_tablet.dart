// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_filter_trips_widget/bx_filter_trips_widget_tablet.dart
// Architecture: Presentation Layer - Filter Trips Widget (Tablet)
// Purpose: Tablet UI for filter trips screen

import 'package:flutter/material.dart';
import 'package:tayara/presentation/widgets/bx_filter_trips_widget/bx_filter_trips_widget_mobile.dart';

class BxFilterTripsWidgetTablet extends StatelessWidget {
  const BxFilterTripsWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: BxFilterTripsWidgetMobile(),
      ),
    );
  }
}
