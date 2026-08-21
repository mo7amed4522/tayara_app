// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_enter_phone_screen/bx_enter_phone_screen.dart
// Architecture: Presentation Layer - Enter Phone Screen
// Purpose: Screen that delegates to mobile/tablet phone entry widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_enter_phone_controller/bx_enter_phone_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_enter_phone_widget/bx_enter_phone_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_enter_phone_widget/bx_enter_phone_widget_tablet.dart';

class BxEnterPhoneScreen extends StatelessWidget {
  const BxEnterPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxEnterPhoneControllerBloc(
        useCase: BxDependencyInjector.instance.get(),
      ),
      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxEnterPhoneWidgetMobile(),
        tabletBuilder: (context) => const BxEnterPhoneWidgetTablet(),
      ),
    );
  }
}
