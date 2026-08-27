// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_trip_detail_screen/bx_trip_detail_screen.dart
// Architecture: Presentation Layer - Trip Detail Screen
// Purpose: Screen that delegates to mobile/tablet trip detail widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_trip_detail_controller/bx_trip_detail_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_trip_detail_widget/bx_trip_detail_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_trip_detail_widget/bx_trip_detail_widget_tablet.dart';

class BxTripDetailScreen extends StatelessWidget {
  const BxTripDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxTripDetailControllerBloc(
        packageUsecase: BxDependencyInjector.instance.get(),
      )..add(const BxLoadTripDetail(tripId: '')),
      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxTripDetailWidgetMobile(),
        tabletBuilder: (context) => const BxTripDetailWidgetTablet(),
      ),
    );
  }
}
