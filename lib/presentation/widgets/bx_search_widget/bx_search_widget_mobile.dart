// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_search_widget/bx_search_widget_mobile.dart
// Architecture: Presentation Layer - Search Widget (Mobile)
// Purpose: Mobile UI for search screen — API-backed only, no mock fallbacks.

// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';
import 'package:tayara/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_bloc.dart';

class BxSearchWidgetMobile extends StatelessWidget {
  final String initialKeyword;
  const BxSearchWidgetMobile({super.key, this.initialKeyword = ''});

  @override
  Widget build(BuildContext context) {
    // Trigger initial search if keyword is provided
    if (initialKeyword.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<BxSearchScreenControllerBloc>().add(
          BxUpdateSearchQuery(query: initialKeyword),
        );
        context.read<BxSearchScreenControllerBloc>().add(
          BxSearchCustom(keyword: initialKeyword),
        );
      });
    }

    return Scaffold(
      body: SafeArea(
        child:
            BlocBuilder<
              BxSearchScreenControllerBloc,
              BxSearchScreenControllerState
            >(
              builder: (context, state) {
                final data = state.customSearchResponse?.data;
                final agents = data?.agents ?? const <BxCustomSearchAgent>[];
                final topExplore =
                    data?.topExplore ?? const <BxCustomSearchPackage>[];
                final similar =
                    data?.similarDestinations ??
                    const <BxCustomSearchPackage>[];
                final isLoading =
                    state.status == BxSearchScreenControllerStatus.loading;
                final hasError =
                    state.status == BxSearchScreenControllerStatus.failure;
                final query = state.query.trim();
                final hasQuery = query.isNotEmpty;

                return Column(
                  children: [
                    _SearchTopBar(initialKeyword: initialKeyword),
                    const SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isLoading)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (hasError)
                              _EmptyOrError(
                                message:
                                    state.errorMessage ??
                                    'Failed to load search results',
                                color: BxAppColors.error,
                              ),
                            if (!isLoading && !hasError && !hasQuery)
                              const _EmptyOrError(
                                message:
                                    'Start typing to search destinations, '
                                    'trips, or agencies.',
                              ),
                            if (!isLoading && !hasError && hasQuery) ...[
                              if (agents.isNotEmpty) ...[
                                _SectionTitle(title: 'Agencies for "$query"'),
                                const SizedBox(height: 12),
                                _AgentsList(agents: agents),
                                const SizedBox(height: 24),
                              ],
                              if (topExplore.isNotEmpty) ...[
                                _SectionTitle(
                                  title: 'Trip Packages for "$query"',
                                ),
                                const SizedBox(height: 12),
                                _TripPackagesList(packages: topExplore),
                                const SizedBox(height: 24),
                              ],
                              if (similar.isNotEmpty) ...[
                                _SectionTitle(
                                  title: 'Similar Destinations You May Like',
                                ),
                                const SizedBox(height: 12),
                                _SimilarDestinationsList(packages: similar),
                                const SizedBox(height: 24),
                              ],
                              if (agents.isEmpty &&
                                  topExplore.isEmpty &&
                                  similar.isEmpty) ...[
                                _EmptyOrError(
                                  message: 'No results found for "$query".',
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }
}

// ── Shared empty/error banner ────────────────────────────────
class _EmptyOrError extends StatelessWidget {
  final String message;
  final Color? color;
  const _EmptyOrError({required this.message, this.color});

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Text(
        message,
        style: TextStyle(
          color: color ?? p.textSecondary,
          fontSize: 14,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}

// ── Palette (unchanged) ──────────────────────────────────────
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
  final String initialKeyword;
  const _SearchTopBar({this.initialKeyword = ''});

  @override
  State<_SearchTopBar> createState() => _SearchTopBarState();
}

class _SearchTopBarState extends State<_SearchTopBar> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Use the initialKeyword passed from parent, or fall back to bloc state
    final initial = widget.initialKeyword.isNotEmpty
        ? widget.initialKeyword
        : context.read<BxSearchScreenControllerBloc>().state.query;
    _controller = TextEditingController(text: initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    context.read<BxSearchScreenControllerBloc>().add(
      BxUpdateSearchQuery(query: value),
    );

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final kw = value.trim();
      context.read<BxSearchScreenControllerBloc>().add(
        BxSearchCustom(keyword: kw),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back, color: p.textPrimary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                controller: _controller,
                autofocus: _controller.text.isEmpty,
                onChanged: _onChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (v) => _onChanged(v),
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
            icon: Image.asset(BxAppConstant.sliderIcon, width: 24, height: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
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
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: _SearchPalette.of(context).textPrimary,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}

// ── Agencies list (API) ──────────────────────────────────────
class _AgentsList extends StatelessWidget {
  final List<BxCustomSearchAgent> agents;
  const _AgentsList({required this.agents});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: agents.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, i) => _AgentCard(agent: agents[i]),
        ),
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final BxCustomSearchAgent agent;
  const _AgentCard({required this.agent});

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);
    final rating = agent.rating ?? 0.0;
    final reviewCount = agent.reviewCount ?? 0;

    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: p.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BxAppColors.primary.withOpacity(0.12),
            ),
            child: _AgentAvatar(url: agent.headerImg),
          ),
          const SizedBox(height: 8),
          Text(
            agent.companyName ?? 'Unknown Agency',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'lao-mn',
              color: p.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 11,
                  color: p.textSecondary,
                  fontFamily: 'lao-mn',
                ),
              ),
              const SizedBox(width: 2),
              Text(
                '($reviewCount)',
                style: TextStyle(
                  fontSize: 9,
                  color: p.textMuted,
                  fontFamily: 'lao-mn',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 80,
            height: 28,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: BxAppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              child: const Text('View Trips'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentAvatar extends StatelessWidget {
  final String? url;
  const _AgentAvatar({this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const Center(
        child: Text(
          'logo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: BxAppColors.primary,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }
    return ClipOval(
      child: Image.network(
        url!,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const Center(
          child: Icon(Icons.business, color: BxAppColors.primary),
        ),
      ),
    );
  }
}

// ── Trip Packages (API) ──────────────────────────────────────
class _TripPackagesList extends StatelessWidget {
  final List<BxCustomSearchPackage> packages;
  const _TripPackagesList({required this.packages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: packages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, i) => _TripPackageCard(pkg: packages[i]),
    );
  }
}

class _TripPackageCard extends StatelessWidget {
  final BxCustomSearchPackage pkg;
  const _TripPackageCard({required this.pkg});

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);
    final bps = pkg.discountPercent ?? 0;
    final percent = (bps / 100).round(); // basis points → percent
    final hasDiscount = percent > 0;
    final days = pkg.daysDuration ?? 0;
    final nights = days > 0 ? days - 1 : 0;

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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: (pkg.coverImageUrl ?? '').isNotEmpty
                      ? Image.network(
                          pkg.coverImageUrl!,
                          width: double.infinity,
                          height: 192,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _imagePlaceholder(p),
                        )
                      : _imagePlaceholder(p),
                ),
                if (hasDiscount)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: BxAppColors.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Save $percent%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    pkg.name ?? 'Unknown Package',
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
                          pkg.companyName ?? 'Unknown Agency',
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
                          days > 0 ? '$days Days · $nights Nights' : '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: p.textSecondary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (pkg.displayPrice != null)
                        Text(
                          '\$${(pkg.displayPrice! / 100).toStringAsFixed(0)}',
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

  Widget _imagePlaceholder(_SearchPalette p) {
    return Container(
      width: double.infinity,
      height: 192,
      color: p.imagePlaceholder,
      child: Icon(Icons.photo_library, size: 48, color: p.iconMuted),
    );
  }
}

// ── Similar Destinations (API) ───────────────────────────────
class _SimilarDestinationsList extends StatelessWidget {
  final List<BxCustomSearchPackage> packages;
  const _SimilarDestinationsList({required this.packages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: packages.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _SimilarDestinationCard(pkg: packages[i]),
      ),
    );
  }
}

class _SimilarDestinationCard extends StatelessWidget {
  final BxCustomSearchPackage pkg;
  const _SimilarDestinationCard({required this.pkg});

  @override
  Widget build(BuildContext context) {
    final p = _SearchPalette.of(context);

    return Container(
      width: 300,
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
              width: 250,
              height: 96,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  (pkg.coverImageUrl ?? '').isNotEmpty
                      ? Image.network(
                          pkg.coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: p.imagePlaceholder,
                            child: Icon(
                              Icons.photo_library,
                              size: 32,
                              color: p.iconMuted,
                            ),
                          ),
                        )
                      : Container(
                          color: p.imagePlaceholder,
                          child: Icon(
                            Icons.photo_library,
                            size: 32,
                            color: p.iconMuted,
                          ),
                        ),
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
                      pkg.name ?? pkg.category ?? 'Destination',
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
                  width: 250,
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
