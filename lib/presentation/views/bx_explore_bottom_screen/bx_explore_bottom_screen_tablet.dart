// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_tablet.dart
// Architecture: Presentation Layer - Explore Bottom Screen
// Purpose: Tablet explore bottom screen implementation

import 'package:flutter/material.dart';
import 'bx_explore_bottom_screen_mobile.dart';

class BxExploreBottomScreenTablet extends StatelessWidget {
  const BxExploreBottomScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: const BxExploreBottomScreenMobile(),
      ),
    );
  }
}
