// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_search_widget/bx_search_widget_tablet.dart
// Architecture: Presentation Layer - Search Widget (Tablet)
// Purpose: Tablet UI for search screen

import 'package:flutter/material.dart';
import 'package:tayara/presentation/widgets/bx_search_widget/bx_search_widget_mobile.dart';

class BxSearchWidgetTablet extends StatelessWidget {
  final String initialKeyword;
  const BxSearchWidgetTablet({super.key, this.initialKeyword = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: BxSearchWidgetMobile(initialKeyword: initialKeyword),
      ),
    );
  }
}
