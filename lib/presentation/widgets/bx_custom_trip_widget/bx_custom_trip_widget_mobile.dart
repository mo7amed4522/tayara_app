// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_custom_trip_widget/bx_custom_trip_widget_mobile.dart
// Architecture: Presentation Layer - Custom Trip Widget (Mobile)
// Purpose: Mobile UI for custom trip planning screen — delegates state to BLoC

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_custom_trip_controller/bx_custom_trip_controller_bloc.dart';

class BxCustomTripWidgetMobile extends StatelessWidget {
  const BxCustomTripWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) =>
          BxCustomTripControllerBloc()..add(const BxLoadCustomTrip()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFA),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: const Color(0xFF2E2E2E),
          title: Text(
            'Custom Trip Planning',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2E2E2E),
              fontFamily: 'lao-mn',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2E2E2E)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body:
            BlocBuilder<
              BxCustomTripControllerBloc,
              BxCustomTripControllerState
            >(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      _CtaButton(),
                      const SizedBox(height: 16),
                      _StepIndicator(activeStep: state.activeStep),
                      const SizedBox(height: 20),
                      _DestinationSection(
                        textTheme: textTheme,
                        selectedSegment: state.selectedSegment,
                        onSegmentSelected: (index) => context
                            .read<BxCustomTripControllerBloc>()
                            .add(BxSelectSegment(segmentIndex: index)),
                      ),
                      const SizedBox(height: 16),
                      _PopularDestinationsCard(
                        textTheme: textTheme,
                        selectedDestination: state.selectedDestination,
                        onDestinationSelected: (dest) => context
                            .read<BxCustomTripControllerBloc>()
                            .add(BxSelectDestination(destination: dest)),
                      ),
                      const SizedBox(height: 16),
                      _SelectedDestination(
                        destination: state.selectedDestination,
                      ),
                      const SizedBox(height: 24),
                      _NextStepButton(
                        onTap: () => context
                            .read<BxCustomTripControllerBloc>()
                            .add(const BxAdvanceStep()),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}

// ── CTA Button ───────────────────────────────────────────────
class _CtaButton extends StatelessWidget {
  const _CtaButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 88,
      decoration: BoxDecoration(
        color: BxAppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Build Your Own Trip',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'lao-mn',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Customize every detail to match your preferences',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xE6FFFFFF),
              fontFamily: 'lao-mn',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step Indicator ───────────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  final int activeStep;
  const _StepIndicator({required this.activeStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Destination',
      'Flights Hotels',
      'Activities',
      'Itinerary',
      'Review',
    ];
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: List.generate(steps.length, (index) {
          final stepNum = index + 1;
          final isActive = stepNum == activeStep;
          final isLast = index == steps.length - 1;

          return Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isActive
                            ? BxAppColors.primary
                            : colorScheme.onSurface.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$stepNum',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF6A7280),
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      steps[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive
                            ? BxAppColors.primary
                            : const Color(0xFF6A7280),
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ],
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ── Destination Section ──────────────────────────────────────
class _DestinationSection extends StatelessWidget {
  final TextTheme textTheme;
  final int selectedSegment;
  final ValueChanged<int> onSegmentSelected;
  const _DestinationSection({
    required this.textTheme,
    required this.selectedSegment,
    required this.onSegmentSelected,
  });

  static const _segments = ['Egypt', 'Jordan', 'Turkey', 'Greece', 'Syria'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Destination',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Select a destination supported by this agency.',
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4A5462),
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 12),
          _SegmentedPicker(
            segments: _segments,
            selectedSegment: selectedSegment,
            onSegmentSelected: onSegmentSelected,
          ),
        ],
      ),
    );
  }
}

class _SegmentedPicker extends StatelessWidget {
  final List<String> segments;
  final int selectedSegment;
  final ValueChanged<int> onSegmentSelected;
  const _SegmentedPicker({
    required this.segments,
    required this.selectedSegment,
    required this.onSegmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(segments.length, (index) {
          final isSelected = index == selectedSegment;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSegmentSelected(index),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? BxAppColors.primary : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  segments[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF374151),
                    fontFamily: 'lao-mn',
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Popular Destinations Card ────────────────────────────────
class _PopularDestinationsCard extends StatelessWidget {
  final TextTheme textTheme;
  final String? selectedDestination;
  final ValueChanged<String> onDestinationSelected;
  const _PopularDestinationsCard({
    required this.textTheme,
    required this.selectedDestination,
    required this.onDestinationSelected,
  });

  static const _destinations = [
    {'name': 'Cairo', 'country': 'Egypt'},
    {'name': 'Bali', 'country': 'Indonesia'},
    {'name': 'Rome', 'country': 'Italy'},
    {'name': 'Tokyo', 'country': 'Japan'},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Destinations from This Agency',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 163.5 / 163.5,
            children: _destinations.map((dest) {
              final key = '${dest['name']}, ${dest['country']}';
              return _DestinationCard(
                name: dest['name']!,
                country: dest['country']!,
                isSelected: selectedDestination == key,
                onTap: () => onDestinationSelected(key),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String name;
  final String country;
  final bool isSelected;
  final VoidCallback onTap;
  const _DestinationCard({
    required this.name,
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: BxAppColors.primary, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF9CA3AF),
                  size: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  Text(
                    country,
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4A5462),
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Selected Destination Info ────────────────────────────────
class _SelectedDestination extends StatelessWidget {
  final String? destination;
  const _SelectedDestination({required this.destination});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Destination',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            destination ?? 'Rome, Italy',
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF374151),
              fontFamily: 'lao-mn',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Next Step Button ─────────────────────────────────────────
class _NextStepButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NextStepButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: BxAppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          'Next Step',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'lao-mn',
          ),
        ),
      ),
    );
  }
}
