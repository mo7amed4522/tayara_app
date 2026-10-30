// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_package_detail_screen/bx_package_detail_screen.dart
// Architecture: Presentation Layer - Bx Package Detail Screen
// Purpose: Main bx package detail screen that delegates to mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_tablet.dart';

class BxPackageDetailScreen extends StatelessWidget {
  const BxPackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxPackageDetailWidgetMobile(),
        tabletBuilder: (context) => const BxPackageDetailWidgetTablet(),
      ),
    );
  }
}
