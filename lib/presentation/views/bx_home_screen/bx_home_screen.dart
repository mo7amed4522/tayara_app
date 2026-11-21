// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_home_screen/bx_home_screen.dart
// Architecture: Presentation Layer - Bx Home Screen
// Purpose: Home Screen shell — keeps tab Blocs alive via DI singletons so
//          swipe/tap does NOT re-fetch. PageView is NOT inside BlocBuilder
//          (only bottom bar rebuilds). Tabs reuse blocs via BlocProvider.value.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_home_widget/bx_home_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_home_widget/bx_home_widget_tablet.dart';

class BxHomeScreen extends StatelessWidget {
  const BxHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxHomeScreenControllerBloc(),
      child: const _BxHomeScreenView(),
    );
  }
}

class _BxHomeScreenView extends StatefulWidget {
  const _BxHomeScreenView();

  @override
  State<_BxHomeScreenView> createState() => _BxHomeScreenViewState();
}

class _BxHomeScreenViewState extends State<_BxHomeScreenView> {
  @override
  void initState() {
    super.initState();
    final homeBloc = BxDependencyInjector.instance
        .get<BxHomeBottomScreenControllerBloc>();
    if (homeBloc.state.status == BxHomeBottomScreenControllerStatus.initial) {
      homeBloc.add(const BxLoadHomeContentEvent());
    }
  }

  void _loadTabIfNeeded(BuildContext context, int index) {
    switch (index) {
      case 0:
        final bloc = context.read<BxHomeBottomScreenControllerBloc>();
        if (bloc.state.status == BxHomeBottomScreenControllerStatus.initial) {
          bloc.add(const BxLoadHomeContentEvent());
        }
        return;
      case 1:
        final bloc = context.read<BxExploreBottomScreenControllerBloc>();
        if (bloc.state.status ==
            BxExploreBottomScreenControllerStatus.initial) {
          bloc.add(const BxLoadExploreContent());
        }
        return;
      case 2:
        // Booking currently has no data-loading endpoint.
        return;
      case 3:
        final bloc = context.read<BxProfileBottomScreenControllerBloc>();
        if (bloc.state.status ==
            BxProfileBottomScreenControllerStatus.initial) {
          bloc
            ..add(const BxLoadProfileThemeEvent())
            ..add(const BxLoadProfileEvent());
        }
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final injector = BxDependencyInjector.instance;
    final homeTabBloc = injector.get<BxHomeBottomScreenControllerBloc>();
    final exploreTabBloc = injector.get<BxExploreBottomScreenControllerBloc>();
    final bookingTabBloc = injector.get<BxBookingBottomScreenControllerBloc>();
    final profileTabBloc = injector.get<BxProfileBottomScreenControllerBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<BxHomeBottomScreenControllerBloc>.value(value: homeTabBloc),
        BlocProvider<BxExploreBottomScreenControllerBloc>.value(value: exploreTabBloc),
        BlocProvider<BxBookingBottomScreenControllerBloc>.value(value: bookingTabBloc),
        BlocProvider<BxProfileBottomScreenControllerBloc>.value(value: profileTabBloc),
      ],
      child: BlocListener<BxHomeScreenControllerBloc, BxHomeScreenControllerState>(
        listener: _onTabChanged,
        child: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxHomeWidgetMobile(),
          tabletBuilder: (context) => const BxHomeWidgetTablet(),
        ),
      ),
    );
  }

  void _onTabChanged(
    BuildContext context,
    BxHomeScreenControllerState state,
  ) {
    _loadTabIfNeeded(context, state.selectedIndex);
  }
}
