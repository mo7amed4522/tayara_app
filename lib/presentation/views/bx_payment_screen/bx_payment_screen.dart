// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_payment_screen/bx_payment_screen.dart
// Architecture: Presentation Layer - Payment Screen
// Purpose: Screen that delegates to mobile/tablet payment widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_payment_widget/bx_payment_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_payment_widget/bx_payment_widget_tablet.dart';

class BxPaymentScreen extends StatelessWidget {
  const BxPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxPaymentWidgetMobile(),
        tabletBuilder: (context) => const BxPaymentWidgetTablet(),
      ),
    );
  }
}
