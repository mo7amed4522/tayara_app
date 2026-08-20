// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_payment_widget/bx_payment_widget_tablet.dart
// Architecture: Presentation Layer - Payment Widget (Tablet)
// Purpose: Tablet UI for payment screen

import 'package:flutter/material.dart';
import 'package:tayara/presentation/widgets/bx_payment_widget/bx_payment_widget_mobile.dart';

class BxPaymentWidgetTablet extends StatelessWidget {
  const BxPaymentWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: BxPaymentWidgetMobile(),
      ),
    );
  }
}
