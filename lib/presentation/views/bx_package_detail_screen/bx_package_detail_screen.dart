// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_package_detail_screen/bx_package_detail_screen.dart
// Architecture: Presentation Layer - Bx Package Detail Screen
// Purpose: Hosts the BLoC and delegates to mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_tablet.dart';

class BxPackageDetailScreen extends StatelessWidget {
  final int packageId;

  const BxPackageDetailScreen({super.key, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxPackageDetailScreenControllerBloc(
        getPackageDetailUsecase: BxDependencyInjector.instance.get(),
      )..add(BxLoadPackageDetail(packageId: packageId)),
      child: Scaffold(
        body: BxResponsiveBuilder(
          mobileBuilder: (context) => const BxPackageDetailWidgetMobile(),
          tabletBuilder: (context) => const BxPackageDetailWidgetTablet(),
        ),
      ),
    );
  }
}
