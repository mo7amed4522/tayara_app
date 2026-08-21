// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_custom_trip_widget/bx_custom_trip_widget_tablet.dart
// Architecture: Presentation Layer - Custom Trip Widget (Tablet)
// Purpose: Tablet UI for custom trip planning screen

import 'package:flutter/material.dart';
import 'package:tayara/presentation/widgets/bx_custom_trip_widget/bx_custom_trip_widget_mobile.dart';

class BxCustomTripWidgetTablet extends StatelessWidget {
  const BxCustomTripWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: BxCustomTripWidgetMobile(),
      ),
    );
  }
}
