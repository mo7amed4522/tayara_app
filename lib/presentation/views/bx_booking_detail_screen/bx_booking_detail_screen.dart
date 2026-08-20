// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_booking_detail_screen/bx_booking_detail_screen.dart
// Architecture: Presentation Layer - Booking Detail Screen
// Purpose: Screen that delegates to mobile/tablet booking detail widgets
// Accepts 'status' argument: 'pending', 'confirmed', or 'expired'

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_booking_detail_widget/bx_booking_detail_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_booking_detail_widget/bx_booking_detail_widget_tablet.dart';

class BxBookingDetailScreen extends StatelessWidget {
  final String status;

  const BxBookingDetailScreen({super.key, this.status = 'pending'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => BxBookingDetailWidgetMobile(status: status),
        tabletBuilder: (context) => BxBookingDetailWidgetTablet(status: status),
      ),
    );
  }
}
