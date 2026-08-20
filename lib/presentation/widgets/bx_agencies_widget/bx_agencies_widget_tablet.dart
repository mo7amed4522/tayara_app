// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_agencies_widget/bx_agencies_widget_tablet.dart
// Architecture: Presentation Layer - Agencies Widget (Tablet)
// Purpose: Tablet UI for agencies listing screen

import 'package:flutter/material.dart';
import 'package:tayara/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart';

class BxAgenciesWidgetTablet extends StatelessWidget {
  const BxAgenciesWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: BxAgenciesWidgetMobile(),
      ),
    );
  }
}
