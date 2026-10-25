// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_search_widget/bx_search_widget_mobile.dart
// Architecture: Presentation Layer - Search Widget (Mobile)
// Purpose: Mobile UI for search screen — delegates state to BLoC

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_bloc.dart';

class BxSearchWidgetMobile extends StatelessWidget {
  const BxSearchWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxSearchScreenControllerBloc()..add(const BxLoadSearch()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SearchTopBar(),
                SizedBox(height: 20),
                _TopAgenciesHeader(),
                SizedBox(height: 20),
                _FeaturedAgencyCard(),
                SizedBox(height: 20),
                _RankedAgencyCard(
                  rank: 1,
                  name: 'Nile Explorers',
                  specialty: 'Cultural heritage specialists',
                ),
                SizedBox(height: 15),
                _RankedAgencyCard(
                  rank: 2,
                  name: 'Desert Wanderers',
                  specialty: 'Adventure & safari experts',
                ),
                SizedBox(height: 24),
                _SectionTitle(title: 'Trip Packages in Cairo'),
                SizedBox(height: 20),
                _TripPackageCard(
                  title: 'Pyramids & Sphinx Discovery',
                  agency: 'Pharaoh Adventures',
                  duration: '3 Days · 2 Nights',
                  price: '\$950 - \$1,050',
                ),
                SizedBox(height: 16),
                _TripPackageCard(
                  title: 'Nile Cruise Experience',
                  agency: 'Nile Explorers',
                  duration: '4 Days · 3 Nights',
                  price: '\$1,200 - \$1,450',
                ),
                SizedBox(height: 24),
                _SectionTitle(title: 'Similar Destinations You May Like'),
                SizedBox(height: 12),
                _SimilarDestinationsList(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shared helpers ───────────────────────────────────────────
/// Colors used only in light mode with no dark-theme equivalent in
/// [BxAppColors] — derived to stay legible on dark surfaces.
class _SearchPalette {
  final bool isDark;
  final Color surface;
  final Color cardSurface;
  final Color imagePlaceholder;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color iconMuted;
  final Color starFilled;
  final Color starEmpty;

  const _SearchPalette({
    required this.isDark,
    required this.surface,
    required this.cardSurface,
    required this.imagePlaceholder,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.iconMuted,
    required this.starFilled,
    required this.starEmpty,
  });

  factory _SearchPalette.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return _SearchPalette(
      isDark: isDark,
      surface: scheme.surface,
      cardSurface: scheme.surface,
      imagePlaceholder: isDark
          ? BxAppColors.darkSurface
          : const Color(0xFFF3F4F6),
      border: isDark ? BxAppColors.darkBorder : const Color(0xFFE5E7EB),
      textPrimary: isDark ? BxAppColors.darkOnSurface : const Color(0xFF111827),
      textSecondary: isDark ? BxAppColors.darkMuted : const Color(0xFF4A5462),
      textMuted: isDark ? BxAppColors.darkMuted : const Color(0xFF6A7280),
      iconMuted: isDark ? BxAppColors.darkMuted : const Color(0xFF9CA3AF),
      starFilled: BxAppColors.amber,
      starEmpty: isDark ? BxAppColors.darkBorder : const Color(0xFFD1D5DB),
    );
  }
}

// ── Search Top Bar ───────────────────────────────────────────
class _SearchTopBar extends StatefulWidget {
  const _SearchTopBar();

  @override
  State<_SearchTopBar> createState() => _SearchTopBarState();
}

class _SearchTopBarState extends State<_SearchTopBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios_new, color: p.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        ),
        Expanded(
          child: SizedBox(
            height: 36,
            child: TextField(
              controller: _controller,
              onChanged: (value) => context
                  .read<BxSearchScreenControllerBloc>()
                  .add(BxUpdateSearchQuery(query: value)),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'lao-mn',
                  color: p.iconMuted,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                isDense: true,
                filled: true,
                fillColor: p.surface,
                suffixIcon: Icon(Icons.search, size: 16, color: p.textMuted),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: p.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: p.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: BxAppColors.primary),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.grid_view_rounded, size: 24, color: p.textPrimary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }
}

// ── Top Agencies Header ──────────────────────────────────────
class _TopAgenciesHeader extends StatelessWidget {
  const _TopAgenciesHeader();

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Agencies in Cairo',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: p.textPrimary,
              fontFamily: 'lao-mn',
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'See All',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: BxAppColors.primary,
                fontFamily: 'lao-mn',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Featured Agency Card ─────────────────────────────────────
class _FeaturedAgencyCard extends StatelessWidget {
  const _FeaturedAgencyCard();

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20.sp,
        constraints: const BoxConstraints(minHeight: 120),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: p.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFEF08A)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 48,
                      color: p.imagePlaceholder,
                      child: Icon(Icons.business, size: 24, color: p.iconMuted),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    top: -8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF08A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        size: 12,
                        color: Color(0xFFCA8A04),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pharaoh Adventures',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: p.textPrimary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 14, color: p.starFilled),
                          const SizedBox(width: 3),
                          Text(
                            '4.7 (156 reviews)',
                            style: TextStyle(
                              fontSize: 11,
                              color: p.textSecondary,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          '15 available trips',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: p.textSecondary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _Tag(
                        label: 'Adventure',
                        bg: Color(0xFFF0FDF4),
                        fg: Color(0xFF16A34A),
                      ),
                      _Tag(
                        label: 'Hiking',
                        bg: Color(0xFFEFF6FF),
                        fg: Color(0xFF2563EB),
                      ),
                      _Tag(
                        label: 'Nature',
                        bg: Color(0xFFFEFCE8),
                        fg: Color(0xFFCA8A04),
                      ),
                    ],
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

class _Tag extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const _Tag({required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    // Tags keep their Figma pastel backgrounds in both themes because
    // the label text is always a saturated hue that reads on pastel.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: fg,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}

// ── Ranked Agency Card ───────────────────────────────────────
class _RankedAgencyCard extends StatelessWidget {
  final int rank;
  final String name;
  final String specialty;
  const _RankedAgencyCard({
    required this.rank,
    required this.name,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20.sp,
        constraints: const BoxConstraints(minHeight: 80),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: p.cardSurface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(p.isDark ? 0.3 : 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: p.imagePlaceholder,
                      child: Icon(Icons.business, size: 20, color: p.iconMuted),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    top: -4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: BxAppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$rank',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // <- fixes the 2px overflow
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: p.textPrimary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        4,
                        (_) => Icon(Icons.star, size: 11, color: p.starFilled),
                      ),
                      Icon(Icons.star_border, size: 11, color: p.starEmpty),
                      const SizedBox(width: 4),
                      Text(
                        '(4.7)',
                        style: TextStyle(
                          fontSize: 11,
                          color: p.textSecondary,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    specialty,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: p.textMuted,
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

// ── Section Title ────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: _SearchPalette.of(context).textPrimary,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}

// ── Trip Package Card ────────────────────────────────────────
class _TripPackageCard extends StatelessWidget {
  final String title;
  final String agency;
  final String duration;
  final String price;
  const _TripPackageCard({
    required this.title,
    required this.agency,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20.sp,
        constraints: const BoxConstraints(minHeight: 351),
        decoration: BoxDecoration(
          color: p.cardSurface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(p.isDark ? 0.35 : 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                width: 343,
                height: 192,
                color: p.imagePlaceholder,
                child: Icon(Icons.photo_library, size: 48, color: p.iconMuted),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: p.textPrimary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.business,
                        size: 13,
                        color: BxAppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          agency,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: p.textSecondary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          duration,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: p.textSecondary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BxAppColors.primary,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 37,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BxAppColors.primary,
                        foregroundColor: BxAppColors.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'lao-mn',
                        ),
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
  }
}

// ── Similar Destinations ─────────────────────────────────────
class _SimilarDestinationsList extends StatelessWidget {
  const _SimilarDestinationsList();

  static const _destinations = ['Luxor', 'Aswan', 'Alexandria', 'Giza'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _destinations.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            _SimilarDestinationCard(name: _destinations[index]),
      ),
    );
  }
}

class _SimilarDestinationCard extends StatelessWidget {
  final String name;
  const _SimilarDestinationCard({required this.name});

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Container(
      width: 160,
      height: 152,
      decoration: BoxDecoration(
        color: p.cardSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(p.isDark ? 0.35 : 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              width: 160,
              height: 96,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: p.imagePlaceholder,
                    child: Icon(
                      Icons.photo_library,
                      size: 32,
                      color: p.iconMuted,
                    ),
                  ),
                  // Gradient scrim so the white label stays readable
                  // regardless of the eventual image behind it.
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x66000000)],
                        ),
                      ),
                      child: SizedBox(height: 32),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 8,
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: SizedBox(
                  width: 136,
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BxAppColors.primary,
                      foregroundColor: BxAppColors.onPrimary,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
