// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_on_boarding_widget/bx_on_boarding_widget_tablet.dart
// Architecture: Presentation Layer - Bx On Boarding Widget
// Purpose: Professional Bx On Boarding widget for tablet devices

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_bloc.dart';

class BxOnBoardingWidgetTablet extends StatelessWidget {
  BxOnBoardingWidgetTablet({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      BxOnBoardingControllerBloc,
      BxOnBoardingControllerState
    >(
      listener: (context, state) {
        final current = _pageController.page?.round() ?? 0;
        if (state.currentPage != current && _pageController.hasClients) {
          _pageController.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        final pages = state.pages;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      context.read<BxOnBoardingControllerBloc>().add(
                        BxOnBoardingPageChanged(index),
                      );
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            page.imagePath,
                            width: 380,
                            height: 480,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64),
                            child: Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onBackground.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 0, 48, 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(pages.length, (index) {
                          final isActive = index == state.currentPage;
                          return GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Image.asset(
                                isActive
                                    ? BxAppConstant.active
                                    : BxAppConstant.notActive,
                                width: 28,
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (state.currentPage < pages.length - 1) {
                            context.read<BxOnBoardingControllerBloc>().add(
                              BxOnBoardingNextPage(),
                            );
                          } else {
                            context.read<BxOnBoardingControllerBloc>().add(
                              BxOnBoardingSkip(context),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(56),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          state.currentPage == pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
