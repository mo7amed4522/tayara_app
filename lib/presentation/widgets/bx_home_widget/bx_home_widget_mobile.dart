// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_home_widget/bx_home_widget_mobile.dart
// Architecture: Presentation Layer - Bx Home Widget
// Purpose: Mobile home screen with custom bottom navigation bar and PageView

// ignore_for_file: deprecated_member_use, sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:tayara/presentation/views/bx_booking_bottom_screen/bx_booking_bottom_screen_mobile.dart';
import 'package:tayara/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_mobile.dart';
import 'package:tayara/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_mobile.dart';
import 'package:tayara/presentation/views/bx_profile_bottom_screen/bx_profile_bottom_screen_mobile.dart';
import '../../bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart';
import '../../bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart';
import '../../../data/data_source/local/bx_shared_preferences_datasource.dart';
import '../../../injection/bx_dependency_injector.dart';

/// Mobile home screen with custom bottom navigation bar.
class BxHomeWidgetMobile extends StatefulWidget {
  const BxHomeWidgetMobile({super.key});

  @override
  State<BxHomeWidgetMobile> createState() => _BxHomeWidgetMobileState();
}

class _BxHomeWidgetMobileState extends State<BxHomeWidgetMobile>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animController;
  late final Animation<double> _slideAnimation;

  static const double _barHeight = 80.0;
  static const double _circleRadius = 24.0;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation = _animController.drive(Tween<double>(begin: 0, end: 1));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (index == _previousIndex) return;
    _previousIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    context.read<BxHomeScreenControllerBloc>().add(
      BxChangeHomeTab(tabIndex: index),
    );
    _animController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxHomeScreenControllerBloc, BxHomeScreenControllerState>(
      builder: (context, state) {
        final currentIndex = state.selectedIndex;
        if (_previousIndex != currentIndex) {
          _previousIndex = currentIndex;
          _animController.forward(from: 0);
        }

        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<BxHomeScreenControllerBloc>().add(
                BxChangeHomeTab(tabIndex: index),
              );
            },
            children: [
              BlocProvider(
                create: (_) => BxHomeBottomScreenControllerBloc(
                  homeUsecase: BxDependencyInjector.instance.get(),
                ),
                child: const BxHomeBottomScreenMobile(),
              ),
              BlocProvider(
                create: (_) => BxExploreBottomScreenControllerBloc(
                  homeUsecase: BxDependencyInjector.instance.get(),
                )..add(const BxLoadExploreContent()),
                child: const BxExploreBottomScreenMobile(),
              ),
              BlocProvider(
                create: (_) => BxBookingBottomScreenControllerBloc(
                  bookingUsecase: BxDependencyInjector.instance.get(),
                )..add(const BxLoadBookings()),
                child: const BxBookingBottomScreenMobile(),
              ),
              BlocProvider(
                create: (context) => BxProfileBottomScreenControllerBloc(
                  sharedPreferencesDataSource: BxDependencyInjector.instance
                      .get<BxSharedPreferencesDataSource>(),
                  profileUsecase: BxDependencyInjector.instance.get(),
                )..add(BxLoadProfileThemeEvent()),
                child: const BxProfileBottomScreenMobile(),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomNavBar(currentIndex),
        );
      },
    );
  }

  Widget _buildBottomNavBar(int selectedIndex) {
    final tabs = const [
      _BottomNavItem(image: BxAppConstant.homeIcon, label: 'Home'),
      _BottomNavItem(image: BxAppConstant.exploreIcon, label: 'Explor'),
      _BottomNavItem(image: BxAppConstant.bookingsIcon, label: 'Bookings'),
      _BottomNavItem(image: BxAppConstant.profileIcon, label: 'Profile'),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / tabs.length;

    final circleCenterY = _barHeight;
    final circleTop = circleCenterY - _circleRadius;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Navigation bar background (fixed: color is now inside BoxDecoration)
        Container(
          height: _barHeight,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
        ),

        // 2. Moving semicircle (behind the tab content)
        AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            final prevCenterX = _previousIndex * tabWidth + tabWidth / 2;
            final currCenterX = selectedIndex * tabWidth + tabWidth / 2;
            final centerX =
                prevCenterX +
                (currCenterX - prevCenterX) * _slideAnimation.value;
            final circleLeft = centerX - _circleRadius;

            return Positioned(
              left: circleLeft,
              top: circleTop,
              child: SizedBox(
                width: _circleRadius * 2,
                height: _circleRadius * 3,
                child: ClipPath(
                  clipper: _TopHalfClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          BxAppColors.primary,
                          BxAppColors.primary.withValues(alpha: 0.001),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // 3. Tab content (icons and labels) – drawn on top
        Container(
          height: _barHeight,
          child: Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onTabChanged(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        tabs[index].image,
                        color: isSelected
                            ? BxAppColors.primary
                            : const Color(0xFF6B7280),
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tabs[index].label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? BxAppColors.primary
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// Clips the BOTTOM half, keeping only the top semicircle.
class _TopHalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start at left (π), sweep 180° clockwise → top half
    path.addArc(Rect.fromLTWH(0, 0, size.width, size.height), pi, pi);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BottomNavItem {
  final String image;
  final String label;

  const _BottomNavItem({required this.image, required this.label});
}
