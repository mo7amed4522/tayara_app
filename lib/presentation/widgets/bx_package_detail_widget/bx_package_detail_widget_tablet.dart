// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_tablet.dart
// Architecture: Presentation Layer - Bx package detail tablet Widget
// Purpose: Professional Bx package detail tablet widget for Tablet devices

// ignore_for_file: unnecessary_underscores, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/response/bx_get_package_detail_response.dart';
import 'package:tayara/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_bloc.dart';

// ── Accent colors (shared with mobile) ───────────────────────
const Color _green = Color(0xFF10B981);
const Color _orange = Color(0xFFEA580C);
const Color _blue = Color(0xFF2563EB);
const Color _peak = Color(0xFFF97316);
const Color _red = Color(0xFFDC2626);
const Color _amber = Color(0xFFF59E0B);

// ── Formatting helpers ───────────────────────────────────────
String _fmtPrice(num? value) {
  if (value == null) return '—';
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '\$${buf.toString()}';
}

// ── Main widget ──────────────────────────────────────────────
class BxPackageDetailWidgetTablet extends StatelessWidget {
  const BxPackageDetailWidgetTablet({super.key});

  static const double _maxContentWidth = 1024;
  static const double _gutter = 24;

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);

    return BlocBuilder<
      BxPackageDetailScreenControllerBloc,
      BxPackageDetailScreenControllerState
    >(
      builder: (context, state) {
        if (state.status == BxPackageDetailScreenControllerStatus.loading ||
            state.status == BxPackageDetailScreenControllerStatus.initial) {
          return Scaffold(
            backgroundColor: p.isDark
                ? const Color(0xFF0E0E10)
                : const Color(0xFFF7F8FA),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        final data = state.packageDetail?.data;
        if (state.status == BxPackageDetailScreenControllerStatus.failure ||
            data == null) {
          return Scaffold(
            backgroundColor: p.isDark
                ? const Color(0xFF0E0E10)
                : const Color(0xFFF7F8FA),
            body: const _ErrorView(),
          );
        }
        return _buildScaffold(context, p, data);
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    _P p,
    BxGetPackageDetailData data,
  ) {
    final images = _imagesFor(data);
    return Scaffold(
      backgroundColor: p.isDark
          ? const Color(0xFF0E0E10)
          : const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: _gutter,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back, color: p.textPrimary),
        ),
        title: Text(
          'Package Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'lao-mn',
            color: p.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined, color: p.textPrimary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, color: p.textPrimary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxContentWidth),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero + summary
                Padding(
                  padding: const EdgeInsets.fromLTRB(_gutter, 16, _gutter, 0),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ImageCarousel(
                              images: images,
                              badge: data.promoTag,
                            ),
                            const SizedBox(height: 16),
                            _SummaryPanel(p: p, data: data),
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _ImageCarousel(
                              images: images,
                              badge: data.promoTag,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: _SummaryPanel(p: p, data: data),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Gallery
                if (images.length > 1) ...[
                  const _SectionTitle('Image Gallery'),
                  _GalleryGrid(images: images),
                ],

                // Itinerary + Included
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final itinerary = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.itineraryDays.isNotEmpty) ...[
                            const _SectionTitleInline('Daily Itinerary'),
                            Column(
                              children: data.itineraryDays
                                  .map((d) => _ItineraryTile(day: d))
                                  .toList(),
                            ),
                          ],
                        ],
                      );
                      final included = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.includes.isNotEmpty) ...[
                            const _SectionTitleInline("What's Included"),
                            ..._IncludedGroups.build(data.includes),
                          ],
                          if (data.excludes.isNotEmpty) ...[
                            const _SectionTitleInline('Not Included'),
                            _InfoCard(
                              icon: Icons.cancel_outlined,
                              color: _red,
                              title: 'Not Included',
                              bulletIcon: Icons.cancel,
                              items: data.excludes
                                  .map((e) => e.itemText ?? '')
                                  .where((s) => s.isNotEmpty)
                                  .toList(),
                            ),
                          ],
                        ],
                      );

                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            itinerary,
                            const SizedBox(height: 8),
                            included,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: itinerary),
                          const SizedBox(width: 20),
                          Expanded(child: included),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Documents
                if (data.documentRequirements.isNotEmpty)
                  _DocumentsCard(
                    gutter: _gutter,
                    requirements: data.documentRequirements,
                  ),

                // Add-ons + Amenities
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final addOns = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.addons.isNotEmpty) ...[
                            const _SectionTitleInline('Optional Add-ons'),
                            _OptionalAddOns(addons: data.addons),
                          ],
                        ],
                      );
                      final amenities = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.highlights.isNotEmpty) ...[
                            const _SectionTitleInline('Highlights'),
                            _AmenitiesGrid(highlights: data.highlights),
                          ],
                        ],
                      );
                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [addOns, amenities],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: addOns),
                          const SizedBox(width: 20),
                          Expanded(child: amenities),
                        ],
                      );
                    },
                  ),
                ),

                // Calendar + Review form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final calendar = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.availability.isNotEmpty) ...[
                            const _SectionTitleInline(
                              'Available Dates & Pricing',
                            ),
                            _CalendarSection(
                              availability: data.availability,
                              basePrice: data.displayPrice,
                            ),
                          ],
                        ],
                      );
                      final review = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline('Write a Review'),
                          _ReviewForm(),
                        ],
                      );
                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [calendar, review],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: calendar),
                          const SizedBox(width: 20),
                          Expanded(child: review),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Review card (static sample — replace when reviews API exists)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: const _ReviewCard(),
                ),

                const SizedBox(height: 20),

                // Booking
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final form = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionTitleInline('Book Your Cruise'),
                          _BookingForm(
                            hotels: data.hotels,
                            requiredFields: data.requiredFields,
                          ),
                        ],
                      );
                      final summary = _BookingSummaryCard(p: p, data: data);
                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [form, const SizedBox(height: 16), summary],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: form),
                          const SizedBox(width: 20),
                          Expanded(flex: 2, child: summary),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static List<String> _imagesFor(BxGetPackageDetailData data) {
    final list = <String>[];
    final cover = data.coverImageUrl;
    if (cover != null && cover.trim().isNotEmpty) list.add(cover);
    final gallery = data.galleryImages?.images ?? const <String>[];
    for (final url in gallery) {
      if (url.trim().isNotEmpty && !list.contains(url)) list.add(url);
    }
    return list;
  }
}

// ═══════════════════════════════════════════════════════════
// ERROR VIEW
// ═══════════════════════════════════════════════════════════
class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: _red),
            const SizedBox(height: 12),
            Text(
              'Unable to load package details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: p.textPrimary,
                fontFamily: 'lao-mn',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SUMMARY PANEL
// ═══════════════════════════════════════════════════════════
class _SummaryPanel extends StatelessWidget {
  final _P p;
  final BxGetPackageDetailData data;
  const _SummaryPanel({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    final discount = data.discountPercent ?? 0;
    final display = data.displayPrice;
    final original = data.originalPrice;
    final showStrike =
        original != null && display != null && original > display;
    final nights = (data.daysDuration ?? 1) - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (discount > 0 || (data.promoTag ?? '').isNotEmpty)
          SizedBox(
            height: 28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (discount > 0)
                  _Badge(text: 'Save $discount%', color: _green),
                if (discount > 0 && (data.promoTag ?? '').isNotEmpty)
                  const SizedBox(width: 8),
                if ((data.promoTag ?? '').isNotEmpty)
                  _Badge(text: data.promoTag!, color: _orange),
              ],
            ),
          ),
        const SizedBox(height: 14),
        Text(
          data.name ?? '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'lao-mn',
            color: p.textPrimary,
          ),
        ),
        if ((data.description ?? '').isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            data.description!,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              fontFamily: 'lao-mn',
              color: p.textSecondary,
            ),
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            const _Stars(rating: 4.9, size: 16),
            const SizedBox(width: 6),
            Text(
              '4.9',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '(127 reviews)',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'lao-mn',
                color: p.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: [
            if (data.daysDuration != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 16, color: p.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    '${data.daysDuration} Days / $nights Nights',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'lao-mn',
                      color: p.textSecondary,
                    ),
                  ),
                ],
              ),
            if ((data.location ?? '').isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: p.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.location!,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'lao-mn',
                      color: p.textSecondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (data.highlights.isNotEmpty) ...[
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final h in data.highlights.take(6))
                if ((h.name ?? '').isNotEmpty)
                  _Chip(text: h.name!, color: _blue),
            ],
          ),
        ],
        const SizedBox(height: 16),
        Divider(height: 1, thickness: 1, color: p.divider),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showStrike) ...[
              Text(
                _fmtPrice(original),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'lao-mn',
                  decoration: TextDecoration.lineThrough,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(width: 10),
            ],
            Text(
              _fmtPrice(display),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'per person • All inclusive',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'lao-mn',
            color: p.textMuted,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'lao-mn',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PALETTE
// ═══════════════════════════════════════════════════════════
class _P {
  final bool isDark;
  final Color card;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color chipBg;
  final Color divider;

  const _P({
    required this.isDark,
    required this.card,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.chipBg,
    required this.divider,
  });

  factory _P.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _P(
      isDark: isDark,
      card: isDark ? const Color(0xFF1A1A1C) : Colors.white,
      border: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E7EB),
      textPrimary: isDark ? Colors.white : const Color(0xFF111827),
      textSecondary: isDark ? const Color(0xFFB4BBC6) : const Color(0xFF4A5462),
      textMuted: isDark ? const Color(0xFF8B94A1) : const Color(0xFF9CA3AF),
      chipBg: isDark ? const Color(0xFF262628) : const Color(0xFFF3F4F6),
      divider: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E7EB),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// NETWORK IMAGE
// ═══════════════════════════════════════════════════════════
class _NetImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const _NetImage({
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
  }) : fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final placeholder = Container(
      width: width,
      height: height,
      color: p.chipBg,
      alignment: Alignment.center,
      child: Icon(Icons.photo_library_outlined, color: p.textMuted, size: 28),
    );
    Widget img = url.isEmpty
        ? placeholder
        : Image.network(
            url,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (_, __, ___) => placeholder,
          );
    if (borderRadius != null) {
      img = ClipRRect(borderRadius: borderRadius!, child: img);
    }
    return img;
  }
}

// ═══════════════════════════════════════════════════════════
// IMAGE CAROUSEL
// ═══════════════════════════════════════════════════════════
class _ImageCarousel extends StatefulWidget {
  final List<String> images;
  final String? badge;
  const _ImageCarousel({required this.images, this.badge});

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: 360,
        decoration: BoxDecoration(
          color: _P.of(context).chipBg,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.photo_library_outlined,
          color: _P.of(context).textMuted,
          size: 48,
        ),
      );
    }
    return SizedBox(
      height: 360,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) => _NetImage(
                url: widget.images[i],
                width: double.infinity,
                height: 360,
              ),
            ),
            Positioned(
              top: 14,
              left: 14,
              right: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if ((widget.badge ?? '').isNotEmpty)
                    Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: _blue,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.badge!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'lao-mn',
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 14,
              bottom: 14,
              child: Row(
                children: List.generate(widget.images.length, (i) {
                  final active = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    width: active ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BADGE / CHIP / STARS
// ═══════════════════════════════════════════════════════════
class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'lao-mn',
          color: Colors.white,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final Color color;
  const _Chip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'lao-mn',
          color: color,
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final double rating;
  final double size;
  const _Stars({required this.rating, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final full = i < rating.floor();
        final half = !full && i < rating;
        return Icon(
          full ? Icons.star : (half ? Icons.star_half : Icons.star_border),
          size: size,
          color: _amber,
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SECTION TITLES
// ═══════════════════════════════════════════════════════════
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'lao-mn',
          color: p.textPrimary,
        ),
      ),
    );
  }
}

class _SectionTitleInline extends StatelessWidget {
  final String title;
  const _SectionTitleInline(this.title);

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'lao-mn',
          color: p.textPrimary,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// GALLERY GRID
// ═══════════════════════════════════════════════════════════
class _GalleryGrid extends StatelessWidget {
  final List<String> images;
  const _GalleryGrid({required this.images});

  static const int _maxVisible = 6;

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final gallery = images.length > 1 ? images.sublist(1) : images;
    final shown = gallery.take(_maxVisible).toList();
    final extra = gallery.length - shown.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (context, c) {
          const spacing = 10.0;
          final cols = c.maxWidth >= 700 ? 6 : 3;
          final size = (c.maxWidth - spacing * (cols - 1)) / cols;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final url in shown)
                _NetImage(
                  url: url,
                  width: size,
                  height: size,
                  borderRadius: BorderRadius.circular(16),
                ),
              if (extra > 0)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: p.isDark ? const Color(0xFF262628) : Colors.black54,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$extra\nimages',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ITINERARY TILE
// ═══════════════════════════════════════════════════════════
class _ItineraryTile extends StatelessWidget {
  final BxPackageItineraryDay day;
  const _ItineraryTile({required this.day});

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: p.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
            childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            iconColor: _blue,
            collapsedIconColor: p.textMuted,
            title: Text(
              day.title ?? 'Day ${day.dayNumber ?? ''}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
            ),
            subtitle: (day.description ?? '').isEmpty
                ? null
                : Text(
                    day.description!,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'lao-mn',
                      color: p.textSecondary,
                    ),
                  ),
            children: [
              for (final it in day.items)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((it.time ?? '').isNotEmpty)
                        SizedBox(
                          width: 52,
                          child: Text(
                            it.time!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                              color: _blue,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 52),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((it.title ?? '').isNotEmpty)
                              Text(
                                it.title!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'lao-mn',
                                  color: p.textPrimary,
                                ),
                              ),
                            if ((it.description ?? '').isNotEmpty)
                              Text(
                                it.description!,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  fontFamily: 'lao-mn',
                                  color: p.textSecondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// INCLUDED GROUPS + INFO CARD
// ═══════════════════════════════════════════════════════════
class _IncludedGroups {
  static List<Widget> build(List<BxPackageInclude> includes) {
    final groups = <String, List<String>>{};
    for (final inc in includes) {
      final cat = (inc.category ?? '').trim();
      final key = cat.isEmpty ? 'Included' : cat;
      final text = inc.itemText ?? '';
      if (text.isEmpty) continue;
      groups.putIfAbsent(key, () => []).add(text);
    }
    final entries = groups.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return [
      for (final e in entries)
        _InfoCard(
          icon: _iconForCategory(e.key),
          color: _green,
          title: e.key,
          items: e.value,
        ),
    ];
  }

  static IconData _iconForCategory(String c) {
    final s = c.toLowerCase();
    if (s.contains('meal') || s.contains('dining') || s.contains('food')) {
      return Icons.restaurant_outlined;
    }
    if (s.contains('tour') || s.contains('activity')) {
      return Icons.location_on_outlined;
    }
    if (s.contains('hotel') ||
        s.contains('accommodation') ||
        s.contains('stay')) {
      return Icons.home_outlined;
    }
    return Icons.check_circle_outline;
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final List<String> items;
  final IconData bulletIcon;

  const _InfoCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.items,
    this.bulletIcon = Icons.check_circle,
  });

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: p.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'lao-mn',
                    color: p.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(bulletIcon, size: 16, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          fontFamily: 'lao-mn',
                          color: p.textSecondary,
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

// ═══════════════════════════════════════════════════════════
// DOCUMENTS CARD
// ═══════════════════════════════════════════════════════════
class _DocumentsCard extends StatelessWidget {
  final double gutter;
  final List<BxPackageDocumentRequirement> requirements;
  const _DocumentsCard({required this.gutter, required this.requirements});

  static String _labelForType(int? id) {
    switch (id) {
      case 1:
        return 'Passport copy';
      case 2:
        return 'National ID';
      case 3:
        return 'Personal photo';
      case 4:
        return 'Visa documents';
      default:
        return 'Document #${id ?? '—'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final docs = requirements
        .map((r) => _labelForType(r.documentTypeId))
        .toList();
    if (docs.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: p.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documents Required for This Trip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.schedule, size: 14, color: p.textMuted),
                const SizedBox(width: 4),
                Text(
                  'Most travelers complete this in 2–3 minutes',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'lao-mn',
                    color: p.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 24,
              runSpacing: 10,
              children: [
                for (final d in docs)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, size: 15, color: _green),
                      const SizedBox(width: 6),
                      Text(
                        d,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'lao-mn',
                          color: p.textSecondary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ADD-ONS
// ═══════════════════════════════════════════════════════════
class _OptionalAddOns extends StatefulWidget {
  final List<BxPackageAddon> addons;
  const _OptionalAddOns({required this.addons});

  @override
  State<_OptionalAddOns> createState() => _OptionalAddOnsState();
}

class _OptionalAddOnsState extends State<_OptionalAddOns> {
  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final visible = widget.addons.where((a) => a.active != false).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (var i = 0; i < visible.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(66),
              onTap: () => setState(() {
                _selected.contains(i) ? _selected.remove(i) : _selected.add(i);
              }),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: p.card,
                  borderRadius: BorderRadius.circular(66),
                  border: Border.all(
                    color: _selected.contains(i) ? _blue : p.border,
                    width: _selected.contains(i) ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _selected.contains(i)
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 20,
                      color: _selected.contains(i) ? _blue : p.textMuted,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visible[i].addonType ?? 'Add-on',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                              color: p.textPrimary,
                            ),
                          ),
                          if ((visible[i].priceModel ?? '').isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              visible[i].priceModel!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'lao-mn',
                                color: p.textMuted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (visible[i].estimatedPrice != null)
                      Text(
                        '+${_fmtPrice(visible[i].estimatedPrice)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'lao-mn',
                          color: _blue,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// AMENITIES (from highlights)
// ═══════════════════════════════════════════════════════════
class _AmenitiesGrid extends StatelessWidget {
  final List<BxPackageHighlight> highlights;
  const _AmenitiesGrid({required this.highlights});

  static IconData _iconFor(String? name) {
    final s = (name ?? '').toLowerCase();
    if (s.contains('wifi') || s.contains('internet')) return Icons.wifi;
    if (s.contains('dining') || s.contains('restaurant')) {
      return Icons.restaurant;
    }
    if (s.contains('pool') || s.contains('sun')) {
      return Icons.wb_sunny_outlined;
    }
    if (s.contains('spa')) return Icons.spa_outlined;
    if (s.contains('entertain') || s.contains('music')) {
      return Icons.music_note_outlined;
    }
    if (s.contains('library') || s.contains('book')) {
      return Icons.menu_book_outlined;
    }
    if (s.contains('gift') || s.contains('shop')) return Icons.card_giftcard;
    return Icons.star_outline;
  }

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final items = highlights
        .map((h) => MapEntry(_iconFor(h.name), h.name ?? ''))
        .where((e) => e.value.isNotEmpty)
        .toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 600;
        final cols = isWide ? 4 : 2;
        final itemWidth = (c.maxWidth - (cols - 1) * 8) / cols;
        return Wrap(
          spacing: 8,
          runSpacing: 12,
          children: [
            for (final a in items)
              SizedBox(
                width: itemWidth,
                child: Row(
                  children: [
                    Icon(a.key, size: 18, color: _blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        a.value,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'lao-mn',
                          color: p.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CALENDAR SECTION
// ═══════════════════════════════════════════════════════════
class _CalendarSection extends StatefulWidget {
  final List<BxPackageAvailability> availability;
  final int? basePrice;
  const _CalendarSection({required this.availability, required this.basePrice});

  @override
  State<_CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<_CalendarSection> {
  int? _selectedDay;

  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _firstWeekdayOffset = 3;
  static const _daysInMonth = 30;

  Set<int> get _departureDays => {
    for (final a in widget.availability)
      if (DateTime.tryParse(a.startDate ?? '') != null)
        DateTime.parse(a.startDate!).day,
  };

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final departureDays = _departureDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final d in _weekdays)
              Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                      color: p.textMuted,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _firstWeekdayOffset + _daysInMonth,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 44,
          ),
          itemBuilder: (context, index) {
            if (index < _firstWeekdayOffset) return const SizedBox.shrink();
            final day = index - _firstWeekdayOffset + 1;
            final isSelected = _selectedDay == day;
            final hasDeparture = departureDays.contains(day);
            final bg = isSelected
                ? (hasDeparture ? _peak : _blue)
                : Colors.transparent;
            return GestureDetector(
              onTap: () => setState(() => _selectedDay = day),
              child: Center(
                child: Container(
                  width: 38.7,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                      color: isSelected ? Colors.white : p.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: _blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Standard Rate: ${_fmtPrice(widget.basePrice)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'lao-mn',
                    color: p.textSecondary,
                  ),
                ),
              ],
            ),
            if (departureDays.isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _peak,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Departures marked in orange',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'lao-mn',
                      color: p.textSecondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// REVIEW FORM + CARD  (unchanged visual)
// ═══════════════════════════════════════════════════════════
class _ReviewForm extends StatefulWidget {
  const _ReviewForm();

  @override
  State<_ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<_ReviewForm> {
  int _rating = 0;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Rating:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'lao-mn',
                  color: p.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              for (var i = 0; i < 5; i++)
                GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      i < _rating ? Icons.star : Icons.star_border,
                      size: 24,
                      color: _amber,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'lao-mn',
              color: p.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Share your experience...',
              hintStyle: TextStyle(
                fontSize: 13,
                fontFamily: 'lao-mn',
                color: p.textMuted,
              ),
              counterText: '${_controller.text.length}/500',
              counterStyle: TextStyle(
                fontSize: 11,
                fontFamily: 'lao-mn',
                color: p.textMuted,
              ),
              filled: true,
              fillColor: p.chipBg,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: p.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: p.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _blue),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard();

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    // Reviews don't come from this API yet. Keep the visual placeholder.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: p.chipBg,
                child: Icon(Icons.person, color: p.textMuted),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Traveler',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'lao-mn',
                        color: p.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const _Stars(rating: 5, size: 14),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BOOKING FORM
// ═══════════════════════════════════════════════════════════
class _BookingForm extends StatefulWidget {
  final List<BxPackageHotel> hotels;
  final List<BxPackageRequiredField> requiredFields;
  const _BookingForm({required this.hotels, required this.requiredFields});

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  int _cabin = 0;

  InputDecoration _dec(_P p, String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 13,
      fontFamily: 'lao-mn',
      color: p.textMuted,
    ),
    filled: true,
    fillColor: p.chipBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: p.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: p.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: _blue),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final textStyle = TextStyle(
      fontSize: 13,
      fontFamily: 'lao-mn',
      color: p.textPrimary,
    );
    final labelStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'lao-mn',
      color: p.textSecondary,
    );
    final cabins = widget.hotels;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel Date', style: labelStyle),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          style: textStyle,
          decoration: _dec(p, 'Select a date').copyWith(
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: p.textMuted,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Full Name', style: labelStyle),
        const SizedBox(height: 6),
        TextField(style: textStyle, decoration: _dec(p, 'Enter your name')),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Adults', style: labelStyle),
                  const SizedBox(height: 6),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: _dec(p, '0'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Children', style: labelStyle),
                  const SizedBox(height: 6),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    decoration: _dec(p, '0'),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (cabins.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('Cabin Type', style: labelStyle),
          const SizedBox(height: 6),
          Row(
            children: [
              for (var i = 0; i < cabins.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _cabin = i),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: p.card,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _cabin == i ? _blue : p.border,
                          width: _cabin == i ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cabins[i].optionName ??
                                cabins[i].roomType ??
                                'Room',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'lao-mn',
                              color: p.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cabins[i].pricePerNightEst != null
                                ? _fmtPrice(cabins[i].pricePerNightEst)
                                : '—',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                              color: _blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
        const SizedBox(height: 12),
        Text('Special Requests', style: labelStyle),
        const SizedBox(height: 6),
        TextField(
          maxLines: 3,
          style: textStyle,
          decoration: _dec(p, 'Any special requests?'),
        ),
        const SizedBox(height: 16),
        Text('Contact Information', style: labelStyle),
        const SizedBox(height: 6),
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: textStyle,
          decoration: _dec(p, 'Email address'),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.phone,
          style: textStyle,
          decoration: _dec(p, 'Phone number'),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BOOKING SUMMARY CARD
// ═══════════════════════════════════════════════════════════
class _BookingSummaryCard extends StatelessWidget {
  final _P p;
  final BxGetPackageDetailData data;
  const _BookingSummaryCard({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    final unit = data.displayPrice ?? 0;
    final total = unit * 2;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'lao-mn',
              color: p.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          _summaryRow(p, 'Package', '${_fmtPrice(data.displayPrice)} × 2'),
          const SizedBox(height: 8),
          _summaryRow(p, 'Cabin upgrade', '\$0'),
          const SizedBox(height: 8),
          _summaryRow(p, 'Add-ons', '\$0'),
          const SizedBox(height: 12),
          Divider(height: 1, color: p.divider),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'lao-mn',
                  color: p.textSecondary,
                ),
              ),
              Text(
                _fmtPrice(total),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'lao-mn',
                  color: p.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '2 persons',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'lao-mn',
                color: p.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Secure payment via Stripe',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'lao-mn',
                color: p.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showHelpSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.support_agent, size: 20, color: _blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'lao-mn',
                            color: p.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Our support team is here for you',
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'lao-mn',
                            color: p.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: _blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(_P p, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'lao-mn',
            color: p.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'lao-mn',
            color: p.textPrimary,
          ),
        ),
      ],
    );
  }

  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: p.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: p.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.support_agent, color: _blue),
                    const SizedBox(width: 8),
                    Text(
                      'Need Help?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'lao-mn',
                        color: p.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Our support team is here for you',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'lao-mn',
                    color: p.textMuted,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: p.chipBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
