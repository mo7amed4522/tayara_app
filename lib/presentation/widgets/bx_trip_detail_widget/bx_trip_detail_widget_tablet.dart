// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_trip_detail_widget/bx_trip_detail_widget_tablet.dart
// Architecture: Presentation Layer - Trip Detail Widget (Tablet)
// Purpose: Tablet UI for trip detail screen — Figma design, no business logic

import 'package:flutter/material.dart';
import 'bx_trip_detail_widget_mobile.dart';

class BxTripDetailWidgetTablet extends StatelessWidget {
  const BxTripDetailWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const BxTripDetailWidgetMobile(),
        ),
      ),
    );
  }
}
