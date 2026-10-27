// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_agencies_screen/bx_agencies_screen.dart
// Architecture: Presentation Layer - Agencies Screen
// Purpose: Screen that provides the agencies BLoC and delegates to
//          mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/domain/usecase/bx_agent_profile_details_usecase.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_agencies_detail_screen_controller/bx_agencies_detail_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_agencies_widget/bx_agencies_widget_tablet.dart';

class BxAgenciesScreen extends StatelessWidget {
  const BxAgenciesScreen({super.key, this.agentId});

  /// Agent id passed from the caller (e.g. the home "View Trips" button).
  /// When null, the screen shows the first available agent (fallback: 1).
  final int? agentId;

  @override
  Widget build(BuildContext context) {
    final resolvedAgentId = agentId ?? 1;

    return BlocProvider(
      create: (_) => BxAgenciesDetailScreenControllerBloc(
        agentProfileDetailsUsecase: BxDependencyInjector.instance
            .get<BxAgentProfileDetailsUsecase>(),
      )..add(BxLoadAgentProfileDetails(agentId: resolvedAgentId)),

      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxAgenciesWidgetMobile(),
        tabletBuilder: (context) => const BxAgenciesWidgetTablet(),
      ),
    );
  }
}
