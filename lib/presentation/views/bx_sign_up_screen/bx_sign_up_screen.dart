// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_sign_up_screen/bx_sign_up_screen.dart
// Architecture: Presentation Layer - Sign Up Screen
// Purpose: Screen that delegates to mobile/tablet sign up widgets

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_sign_up_controller/bx_sign_up_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_sign_up_widget/bx_sign_up_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_sign_up_widget/bx_sign_up_widget_tablet.dart';

class BxSignUpScreen extends StatelessWidget {
  const BxSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxSignUpControllerBloc(useCase: BxDependencyInjector.instance.get()),
      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const BxSignUpWidgetMobile(),
        tabletBuilder: (context) => const BxSignUpWidgetTablet(),
      ),
    );
  }
}
