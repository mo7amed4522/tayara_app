// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_on_boarding_widget/bx_on_boarding_widget_mobile.dart
// Architecture: Presentation Layer - Bx On Boarding Widget
// Purpose: Professional Bx On Boarding widget for mobile devices

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/presentation/bloc/bx_on_boarding_controller/bx_on_boarding_controller_bloc.dart';

class BxOnBoardingWidgetMobile extends StatelessWidget {
  BxOnBoardingWidgetMobile({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BxOnBoardingControllerBloc, BxOnBoardingControllerState>(
      listener: (context, state) {
        final current = _pageController.page?.round() ?? 0;
        if (state.currentPage != current && _pageController.hasClients) {
          _pageController.animateToPage(state.currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        }
      },
      builder: (context, state) {
        final pages = state.pages;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isLastPage = state.currentPage == pages.length - 1;

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
                      context.read<BxOnBoardingControllerBloc>().add(BxOnBoardingPageChanged(index));
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(page.imagePath, width: 257, height: 336, fit: BoxFit.contain),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(color: colorScheme.onBackground, fontWeight: FontWeight.bold, fontFamily: 'lao-mn'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Bottom area: indicators always visible; button only on last page, arranged vertically
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pages.length, (index) {
                          final isActive = index == state.currentPage;
                          return GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(isActive ? BxAppConstant.active : BxAppConstant.notActive, width: 24, height: 24, fit: BoxFit.contain),
                            ),
                          );
                        }),
                      ),
                      // Show button only on last page, as a separate full-width row below indicators
                      if (isLastPage) ...[
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<BxOnBoardingControllerBloc>().add(BxOnBoardingSkip(context));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56)),
                            minimumSize: const Size(double.infinity, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'lao-mn'),
                          ),
                        ),
                      ],
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
