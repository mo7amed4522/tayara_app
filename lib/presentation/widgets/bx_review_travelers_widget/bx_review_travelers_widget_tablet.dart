// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_review_travelers_widget/bx_review_travelers_widget_tablet.dart
// Architecture: Presentation Layer - Review Travelers Widget (Tablet)
// Purpose: Tablet UI for review travelers screen — stub, no business logic

import 'package:flutter/material.dart';
import 'bx_review_travelers_widget_mobile.dart';

class BxReviewTravelersWidgetTablet extends StatelessWidget {
  const BxReviewTravelersWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const BxReviewTravelersWidgetMobile(),
        ),
      ),
    );
  }
}
