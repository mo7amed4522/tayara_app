// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_similar_trips_widget/bx_similar_trips_widget_tablet.dart
// Architecture: Presentation Layer - Similar Trips Widget (Tablet)
// Purpose: Tablet UI for similar trips screen — stub, no business logic

import 'package:flutter/material.dart';
import 'bx_similar_trips_widget_mobile.dart';

class BxSimilarTripsWidgetTablet extends StatelessWidget {
  const BxSimilarTripsWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const BxSimilarTripsWidgetMobile(),
        ),
      ),
    );
  }
}
