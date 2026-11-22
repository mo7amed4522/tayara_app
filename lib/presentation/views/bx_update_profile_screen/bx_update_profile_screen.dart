// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_update_profile_screen/bx_update_profile_screen.dart
// Architecture: Presentation Layer - Update Profile Entry
// Purpose: Provides the BLoC once at the top of the tree and delegates the
//          actual layout (and the success/failure listener) to the
//          mobile/tablet body widgets.

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/domain/usecase/bx_update_user_data_usecase.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';
import 'package:tayara/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart';
import 'package:tayara/presentation/widgets/bx_update_profile_widget/bx_update_profile_screen_body_mobile.dart';
import 'package:tayara/presentation/widgets/bx_update_profile_widget/bx_update_profile_screen_body_tablet.dart';

class BxUpdateProfileScreen extends StatelessWidget {
  const BxUpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxUpdateProfileScreenControllerBloc(
        updateUserDataUsecase: BxDependencyInjector.instance
            .get<BxUpdateUserDataUsecase>(),
      ),
      child:
          BlocConsumer<
            BxUpdateProfileScreenControllerBloc,
            BxUpdateProfileScreenControllerState
          >(
            listenWhen: (prev, curr) => prev.status != curr.status,
            listener: (context, state) {
              if (state.status ==
                  BxUpdateProfileScreenControllerStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).maybePop();
              } else if (state.status ==
                  BxUpdateProfileScreenControllerStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Update failed'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: _buildAppBar(
                  Theme.of(context),
                  context.read<BxUpdateProfileScreenControllerBloc>(),
                ),
                body: BxResponsiveBuilder(
                  mobileBuilder: (context) =>
                      const BxUpdateProfileScreenBodyMobile(),
                  tabletBuilder: (context) =>
                      const BxUpdateProfileScreenBodyTablet(),
                ),
              );
            },
          ),
    );
  }
}

PreferredSizeWidget _buildAppBar(
  ThemeData theme,
  BxUpdateProfileScreenControllerBloc bloc,
) {
  return AppBar(
    title: const Text('Edit Profile'),
    centerTitle: true,
    elevation: 0,
    backgroundColor: theme.scaffoldBackgroundColor,
    foregroundColor: theme.colorScheme.onBackground,
    actions: [
      IconButton(
        onPressed: () => bloc.add(const BxResetUpdateProfileEvent()),
        icon: const Icon(Icons.refresh),
        tooltip: 'Reset changes',
      ),
    ],
  );
}
