// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_review_travelers_screen/bx_review_travelers_screen.dart
// Architecture: Presentation Layer - Review Travelers Screen
// Purpose: Screen that delegates to mobile/tablet review travelers widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_review_travelers_widget/bx_review_travelers_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_review_travelers_widget/bx_review_travelers_widget_tablet.dart';

class BxReviewTravelersScreen extends StatelessWidget {
  const BxReviewTravelersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxReviewTravelersWidgetMobile(),
        tabletBuilder: (context) => const BxReviewTravelersWidgetTablet(),
      ),
    );
  }
}
