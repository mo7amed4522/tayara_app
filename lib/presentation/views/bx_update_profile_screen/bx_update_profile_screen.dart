// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_update_profile_screen/bx_update_profile_screen.dart
// Architecture: Presentation Layer - Bx Update Profile Screen
// Purpose: Entry widget that provides the update profile BLoC and delegates
//          to the responsive body.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/domain/usecase/bx_update_user_data_usecase.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_update_profile_widget/bx_update_profile_screen_body.dart';

class BxUpdateProfileScreen extends StatelessWidget {
  const BxUpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxUpdateProfileScreenControllerBloc(
        updateUserDataUsecase: BxDependencyInjector.instance
            .get<BxUpdateUserDataUsecase>(),
      ),
      child: const BxResponsiveBuilder(
        mobileBuilder: _mobile,
        tabletBuilder: _tablet,
      ),
    );
  }

  static Widget _mobile(BuildContext context) =>
      const BxUpdateProfileScreenBody();
  static Widget _tablet(BuildContext context) =>
      const BxUpdateProfileScreenBody(isTablet: true);
}
