// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_home_widget/bx_home_widget_tablet.dart
// Architecture: Presentation Layer - Bx Home Widget
// Purpose: Tablet home screen with a horizontal tab slider and PageView

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/domain/usecase/bx_active_top_banner_ads_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_topic_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_trips_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_agent_usecase.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';
import 'package:tayara/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:tayara/presentation/views/bx_booking_bottom_screen/bx_booking_bottom_screen_tablet.dart';
import 'package:tayara/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_tablet.dart';
import 'package:tayara/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_tablet.dart';
import 'package:tayara/presentation/views/bx_profile_bottom_screen/bx_profile_bottom_screen_tablet.dart';
import '../../bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart';
import '../../bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart';
import '../../../data/data_source/local/bx_shared_preferences_datasource.dart';
import '../../../injection/bx_dependency_injector.dart';

/// Tablet home screen featuring a top tab slider instead of a bottom nav bar.
///
/// The slider presents the same four tabs as the mobile view. The selected
/// tab is highlighted with [BxAppColors.primary] ([#2563EB]) and a sliding
/// pill indicator.
class BxHomeWidgetTablet extends StatefulWidget {
  const BxHomeWidgetTablet({super.key});

  @override
  State<BxHomeWidgetTablet> createState() => _BxHomeWidgetTabletState();
}

class _BxHomeWidgetTabletState extends State<BxHomeWidgetTablet>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _sliderController;

  static const double _sliderHeight = 48.0;
  static const double _sliderItemPadding = 24.0;

  late final List<_TabletTab> _tabs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _sliderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _tabs = const [
      _TabletTab(icon: Icons.home, label: 'HOME'),
      _TabletTab(icon: Icons.explore, label: 'EXPLORE'),
      _TabletTab(icon: Icons.bookmarks, label: 'BOOKINGS'),
      _TabletTab(icon: Icons.person, label: 'PROFILE'),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sliderController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    context.read<BxHomeScreenControllerBloc>().add(
      BxChangeHomeTab(tabIndex: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BxHomeScreenControllerBloc, BxHomeScreenControllerState>(
      builder: (context, state) {
        _sliderController.forward(from: 0);
        return Scaffold(
          backgroundColor: BxAppColors.background,
          body: Column(
            children: [
              _buildTabSlider(state.selectedIndex),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<BxHomeScreenControllerBloc>().add(
                      BxChangeHomeTab(tabIndex: index),
                    );
                  },
                  children: [
                    BxHomeBottomScreenTablet(),
                    BlocProvider(
                      create: (_) => BxExploreBottomScreenControllerBloc(
                        getExploreTopicUsecase: BxDependencyInjector.instance.get<BxGetExploreTopicUsecase>(),
                        getTopAgentsUsecase: BxDependencyInjector.instance.get<BxGetTopAgentsUsecase>(),
                        activeTopBannerAdsUsecase: BxDependencyInjector.instance.get<BxActiveTopBannerAdsUsecase>(),
                        getExploreTripsUsecase: BxDependencyInjector.instance.get<BxGetExploreTripsUsecase>(),
                      )..add(const BxLoadExploreContent()),
                      child: const BxExploreBottomScreenTablet(),
                    ),
                    BlocProvider(
                      create: (_) =>
                          BxBookingBottomScreenControllerBloc()
                            ..add(const BxLoadBookings()),
                      child: const BxBookingBottomScreenTablet(),
                    ),
                    BlocProvider(
                      create: (context) => BxProfileBottomScreenControllerBloc(
                        sharedPreferencesDataSource: BxDependencyInjector
                            .instance
                            .get<BxSharedPreferencesDataSource>(),
                      )..add(BxLoadProfileThemeEvent()),
                      child: const BxProfileBottomScreenTablet(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabSlider(int selectedIndex) {
    final totalWidth = MediaQuery.of(context).size.width;
    final itemWidth = (totalWidth - _sliderItemPadding * 2) / _tabs.length;

    return Container(
      height: _sliderHeight,
      color: Colors.white,
      child: Stack(
        children: [
          // Sliding pill indicator
          AnimatedBuilder(
            animation: _sliderController,
            builder: (context, child) {
              final left = _sliderItemPadding + selectedIndex * itemWidth;
              return Positioned(
                left: left,
                top: 6,
                bottom: 6,
                width: itemWidth - 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: BxAppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
          // Tab items
          Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onTabTapped(index),
                  child: Container(
                    height: _sliderHeight,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _tabs[index].icon,
                          color: isSelected
                              ? BxAppColors.primary
                              : const Color(0xFF6B7280),
                          size: 20,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _tabs[index].label,
                          style: TextStyle(
                            fontSize: 12,
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
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TabletTab {
  final IconData icon;
  final String label;

  const _TabletTab({required this.icon, required this.label});
}
