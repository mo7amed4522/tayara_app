// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_tablet.dart
// Architecture: Presentation Layer - Bx package detail tablet Widget
// Purpose: Professional Bx package detail tablet widget for Tablet devices

// ignore_for_file: unnecessary_underscores, deprecated_member_use

import 'package:flutter/material.dart';

// ── Accent colors (shared with mobile) ───────────────────────
const Color _green = Color(0xFF10B981);
const Color _orange = Color(0xFFEA580C);
const Color _blue = Color(0xFF2563EB);
const Color _peak = Color(0xFFF97316);
const Color _red = Color(0xFFDC2626);
const Color _amber = Color(0xFFF59E0B);

// ── Static content ───────────────────────────────────────────
const _description =
    "Experience the ultimate luxury along the legendary Nile River. This "
    "premium 5-day cruise combines world-class amenities with expertly guided "
    "tours of Egypt's most magnificent temples and archaeological sites.";

const _carouselImages = <String>[
  'https://picsum.photos/seed/nile-cruise-1/1600/900',
  'https://picsum.photos/seed/nile-cruise-2/1600/900',
  'https://picsum.photos/seed/nile-cruise-3/1600/900',
  'https://picsum.photos/seed/nile-cruise-4/1600/900',
];

const _galleryImages = <String>[
  'https://picsum.photos/seed/gallery-1/400/400',
  'https://picsum.photos/seed/gallery-2/400/400',
  'https://picsum.photos/seed/gallery-3/400/400',
  'https://picsum.photos/seed/gallery-4/400/400',
  'https://picsum.photos/seed/gallery-5/400/400',
  'https://picsum.photos/seed/gallery-6/400/400',
];

const _reviewerAvatar = 'https://i.pravatar.cc/150?img=47';

const _reviewText =
    'Absolutely magical experience! The cruise ship was luxurious and the '
    'temple tours were incredibly informative. Our Egyptologist guide brought '
    'ancient history to life. The Abu Simbel excursion was the highlight of '
    'our trip.';

class _ItineraryEntry {
  final String title;
  final String subtitle;
  final List<(String, String)> items;
  const _ItineraryEntry(this.title, this.subtitle, this.items);
}

final _itinerary = <_ItineraryEntry>[
  _ItineraryEntry(
    'Day 1: Luxor Embarkation',
    'Temple visits & welcome dinner',
    const [
      ('12:00', 'Check-in and welcome aboard luxury cruise ship'),
      ('14:00', 'Guided tour of Karnak Temple Complex'),
      ('17:00', 'Luxor Temple visit at sunset'),
      ('19:30', 'Welcome dinner and evening entertainment'),
    ],
  ),
  _ItineraryEntry(
    'Day 2: Valley of the Kings',
    'Royal tombs & Hatshepsut Temple',
    const [
      ('08:00', 'Breakfast and early disembarkation'),
      ('09:30', 'Guided tour of the Valley of the Kings'),
      ('13:00', 'Lunch back on board'),
      ('15:30', 'Hatshepsut Temple visit'),
      ('19:00', 'Dinner and evening entertainment'),
    ],
  ),
  _ItineraryEntry(
    'Day 3: Edfu & Kom Ombo',
    'Temple of Horus & Crocodile Temple',
    const [
      ('08:00', 'Breakfast on board'),
      ('09:00', 'Edfu Temple (Temple of Horus) visit'),
      ('13:00', 'Lunch and sail to Kom Ombo'),
      ('16:00', 'Kom Ombo Temple visit'),
      ('19:30', 'Dinner on board'),
    ],
  ),
  _ItineraryEntry('Day 4: Abu Simbel', 'Ramses II masterpiece', const [
    ('04:30', 'Early departure to Abu Simbel'),
    ('07:00', 'Guided tour of Abu Simbel temples'),
    ('12:00', 'Return to cruise ship and lunch'),
    ('16:00', 'Afternoon tea and relaxation'),
    ('19:30', 'Farewell dinner'),
  ]),
  _ItineraryEntry('Day 5: Aswan Departure', 'Philae Temple & farewell', const [
    ('08:00', 'Breakfast and check-out'),
    ('09:00', 'Philae Temple visit'),
    ('12:00', 'Farewell lunch'),
    ('14:00', 'Transfer to Aswan airport'),
  ]),
];

// ── Main widget ──────────────────────────────────────────────
class BxPackageDetailWidgetTablet extends StatelessWidget {
  const BxPackageDetailWidgetTablet({super.key});

  static const double _maxContentWidth = 1024;
  static const double _gutter = 24;

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);

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
                // ── Hero + summary (two column) ──────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(_gutter, 16, _gutter, 0),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      if (!isWide) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _ImageCarousel(),
                            const SizedBox(height: 16),
                            _SummaryPanel(p: p),
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(flex: 3, child: _ImageCarousel()),
                          const SizedBox(width: 20),
                          Expanded(flex: 2, child: _SummaryPanel(p: p)),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ── Gallery ──────────────────────────────────
                _SectionTitle('Image Gallery'),
                _GalleryGrid(),

                // ── Itinerary + Included (two column) ────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final itinerary = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionTitleInline('Daily Itinerary'),
                          Column(
                            children: _itinerary
                                .map((e) => _ItineraryTile(entry: e))
                                .toList(),
                          ),
                        ],
                      );
                      final included = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline("What's Included"),
                          _InfoCard(
                            icon: Icons.home_outlined,
                            color: _green,
                            title: 'Accommodation',
                            items: [
                              '4 nights luxury cruise ship cabin',
                              'Private bathroom with river view',
                              'Daily housekeeping service',
                            ],
                          ),
                          _InfoCard(
                            icon: Icons.restaurant_outlined,
                            color: _green,
                            title: 'Meals & Dining',
                            items: [
                              'All meals: 4 breakfasts, 5 lunches, 4 dinners',
                              'Welcome and farewell dinners',
                              'Afternoon tea and snacks',
                            ],
                          ),
                          _InfoCard(
                            icon: Icons.location_on_outlined,
                            color: _green,
                            title: 'Tours & Activities',
                            items: [
                              'All temple visits with expert Egyptologist',
                              'Abu Simbel excursion by air-conditioned coach',
                              'All entrance fees and permits',
                            ],
                          ),
                          _SectionTitleInline('Not Included'),
                          _InfoCard(
                            icon: Icons.cancel_outlined,
                            color: _red,
                            title: 'Not Included',
                            bulletIcon: Icons.cancel,
                            items: [
                              'International flights to/from Egypt',
                              'Alcoholic beverages',
                              'Personal expenses and tips',
                              'Travel insurance',
                            ],
                          ),
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

                // ── Documents ────────────────────────────────
                const _DocumentsCard(gutter: _gutter),

                // ── Add-ons + Amenities (two column) ─────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final addOns = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline('Optional Add-ons'),
                          _OptionalAddOns(),
                        ],
                      );
                      final amenities = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline('Ship Amenities'),
                          _AmenitiesGrid(),
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

                // ── Calendar + Review form (two column) ──────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final calendar = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline('Available Dates & Pricing'),
                          _CalendarSection(),
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

                // ── Review ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: const _ReviewCard(),
                ),

                const SizedBox(height: 20),

                // ── Booking (two column) ─────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _gutter),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 760;
                      final form = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionTitleInline('Book Your Cruise'),
                          _BookingForm(),
                        ],
                      );
                      final summary = _BookingSummaryCard(p: p);
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
}

// ── Summary panel (title + description + rating + chips + price) ──
class _SummaryPanel extends StatelessWidget {
  final _P p;
  const _SummaryPanel({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges
        SizedBox(
          height: 28,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _Badge(text: 'Save 8%', color: _green),
              SizedBox(width: 8),
              _Badge(text: 'Limited Time', color: _orange),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Luxury Nile Cruise 5D/4N',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'lao-mn',
            color: p.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _description,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontFamily: 'lao-mn',
            color: p.textSecondary,
          ),
        ),
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
        Row(
          children: [
            Icon(Icons.schedule, size: 16, color: p.textMuted),
            const SizedBox(width: 4),
            Text(
              '5 Days / 4 Nights',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'lao-mn',
                color: p.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Icon(Icons.location_on_outlined, size: 16, color: p.textMuted),
            const SizedBox(width: 4),
            Text(
              'Luxor to Aswan',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'lao-mn',
                color: p.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // Feature chips wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _Chip(text: 'Full Board', color: _blue),
            _Chip(text: 'Temple Tours', color: _blue),
            _Chip(text: 'Expert Guide', color: _blue),
            _Chip(text: '5 Star Ship', color: _green),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, thickness: 1, color: p.divider),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$1,200',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'lao-mn',
                decoration: TextDecoration.lineThrough,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '\$1,104',
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

// ── Palette ──────────────────────────────────────────────────
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

// ── Network image helper ─────────────────────────────────────
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

// ── Image carousel (taller on tablet) ────────────────────────
class _ImageCarousel extends StatefulWidget {
  const _ImageCarousel();

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
    return SizedBox(
      height: 360,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _carouselImages.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, i) => _NetImage(
                url: _carouselImages[i],
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
                  Container(
                    width: 72.56,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _blue,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'lao-mn',
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                children: List.generate(_carouselImages.length, (i) {
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

// ── Badge / Chip ─────────────────────────────────────────────
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
        color: color,
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'lao-mn',
          color: Colors.white,
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

// ── Section titles ───────────────────────────────────────────
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

// ── Gallery grid (responsive columns) ────────────────────────
class _GalleryGrid extends StatelessWidget {
  static const int _visible = 6;
  static const int _total = 21;

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    final shown = _galleryImages.take(_visible).toList();
    final more = _total - shown.length;

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
              for (var i = 0; i < shown.length; i++)
                _NetImage(
                  url: shown[i],
                  width: size,
                  height: size,
                  borderRadius: BorderRadius.circular(16),
                ),
              if (more > 0)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: p.isDark ? const Color(0xFF262628) : Colors.black54,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$more\nimages',
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

// ── Itinerary tile ───────────────────────────────────────────
class _ItineraryTile extends StatelessWidget {
  final _ItineraryEntry entry;
  const _ItineraryTile({required this.entry});

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
              entry.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'lao-mn',
                color: p.textPrimary,
              ),
            ),
            subtitle: Text(
              entry.subtitle,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'lao-mn',
                color: p.textSecondary,
              ),
            ),
            children: [
              for (final item in entry.items)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 52,
                        child: Text(
                          item.$1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'lao-mn',
                            color: _blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.$2,
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
      ),
    );
  }
}

// ── Info card ────────────────────────────────────────────────
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

// ── Documents card ───────────────────────────────────────────
class _DocumentsCard extends StatelessWidget {
  final double gutter;
  const _DocumentsCard({required this.gutter});

  static const _docs = [
    ('Passport copy', 'National ID'),
    ('Personal photo', 'Visa documents'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
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
            LayoutBuilder(
              builder: (context, c) {
                final isWide = c.maxWidth >= 600;
                if (!isWide) {
                  return Column(
                    children: [
                      for (final row in _docs)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(child: _docItem(p, row.$1)),
                              const SizedBox(width: 12),
                              Expanded(child: _docItem(p, row.$2)),
                            ],
                          ),
                        ),
                    ],
                  );
                }
                return Row(
                  children: [
                    for (var i = 0; i < _docs.length; i++) ...[
                      if (i > 0) const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _docItem(p, _docs[i].$1),
                            const SizedBox(height: 8),
                            _docItem(p, _docs[i].$2),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: _blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Traveler details will be requested after payment to '
                      'issue your tickets.',
                      style: TextStyle(
                        fontSize: 11,
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

  Widget _docItem(_P p, String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 15, color: _green),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'lao-mn',
              color: p.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Optional add-ons ─────────────────────────────────────────
class _AddOn {
  final String title;
  final String subtitle;
  final String price;
  final String priceUnit;
  final bool isCustom;
  const _AddOn(
    this.title,
    this.subtitle,
    this.price,
    this.priceUnit, {
    this.isCustom = false,
  });
}

const _addOns = [
  _AddOn(
    'Airport VIP Service',
    'Fast-track & lounge access',
    '+\$85',
    'per person',
  ),
  _AddOn(
    'Romantic Dinner',
    'Private sunset dinner for two',
    '+\$180',
    'per couple',
  ),
  _AddOn(
    'Professional Photoshoot',
    '2-hour session with 50+ photos',
    '+\$220',
    'per session',
  ),
  _AddOn(
    'Build Custom Plan',
    'Personalize your entire itinerary',
    '',
    '',
    isCustom: true,
  ),
];

class _OptionalAddOns extends StatefulWidget {
  const _OptionalAddOns();

  @override
  State<_OptionalAddOns> createState() => _OptionalAddOnsState();
}

class _OptionalAddOnsState extends State<_OptionalAddOns> {
  final Set<int> _selected = {};

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return Column(
      children: [
        for (var i = 0; i < _addOns.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(66),
              onTap: _addOns[i].isCustom
                  ? () {}
                  : () => setState(() {
                      _selected.contains(i)
                          ? _selected.remove(i)
                          : _selected.add(i);
                    }),
              child: Container(
                width: double.infinity,
                height: 66,
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
                    if (_addOns[i].isCustom)
                      const Icon(Icons.edit_outlined, size: 20, color: _blue)
                    else
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
                            _addOns[i].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                              color: p.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _addOns[i].subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'lao-mn',
                              color: p.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_addOns[i].isCustom)
                      Icon(Icons.chevron_right, color: p.textMuted)
                    else
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _addOns[i].price,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                              color: _blue,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _addOns[i].priceUnit,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'lao-mn',
                              color: p.textMuted,
                            ),
                          ),
                        ],
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

// ── Ship amenities grid ──────────────────────────────────────
const _amenities = <(IconData, String)>[
  (Icons.wifi, 'Free WiFi'),
  (Icons.restaurant, 'Fine Dining'),
  (Icons.wb_sunny_outlined, 'Sun Deck Pool'),
  (Icons.spa_outlined, 'Spa Services'),
  (Icons.music_note_outlined, 'Live Entertainment'),
  (Icons.menu_book_outlined, 'Library Lounge'),
  (Icons.card_giftcard, 'Gift Shop'),
  (Icons.favorite_border, '24/7 Service'),
];

class _AmenitiesGrid extends StatelessWidget {
  const _AmenitiesGrid();

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 600;
        final cols = isWide ? 4 : 2;
        final itemWidth = (c.maxWidth - (cols - 1) * 8) / cols;
        return Wrap(
          spacing: 8,
          runSpacing: 12,
          children: [
            for (final a in _amenities)
              SizedBox(
                width: itemWidth,
                child: Row(
                  children: [
                    Icon(a.$1, size: 18, color: _blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        a.$2,
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

// ── Calendar section ─────────────────────────────────────────
class _CalendarSection extends StatefulWidget {
  const _CalendarSection();

  @override
  State<_CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<_CalendarSection> {
  int? _selectedDay;

  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _firstWeekdayOffset = 3;
  static const _daysInMonth = 30;
  static const _peakDays = {5, 6, 12, 13, 19, 20, 26, 27};

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
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
            final isPeak = _peakDays.contains(day);
            final bg = isSelected
                ? (isPeak ? _peak : _blue)
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
                  'Standard Rate: \$1,200',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'lao-mn',
                    color: p.textSecondary,
                  ),
                ),
              ],
            ),
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
                  'Peak Season: \$1,500',
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

// ── Review form ──────────────────────────────────────────────
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

// ── Review card ──────────────────────────────────────────────
class _ReviewCard extends StatelessWidget {
  const _ReviewCard();

  @override
  Widget build(BuildContext context) {
    final p = _P.of(context);
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
              ClipOval(
                child: _NetImage(url: _reviewerAvatar, width: 44, height: 44),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Mitchell',
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
              Text(
                'March 2024',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'lao-mn',
                  color: p.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _reviewText,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              fontFamily: 'lao-mn',
              color: p.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Booking form (no submit button — summary card handles it) ──
class _BookingForm extends StatefulWidget {
  const _BookingForm();

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  int _cabin = 0;
  static const _cabins = [
    ('Single room', '\$1,200'),
    ('Deluxe room', '\$1,400'),
  ];

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
        const SizedBox(height: 12),
        Text('Cabin Type', style: labelStyle),
        const SizedBox(height: 6),
        Row(
          children: [
            for (var i = 0; i < _cabins.length; i++) ...[
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
                          _cabins[i].$1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'lao-mn',
                            color: p.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _cabins[i].$2,
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

// ── Booking summary card (sticky-style side panel on tablet) ──
class _BookingSummaryCard extends StatelessWidget {
  final _P p;
  const _BookingSummaryCard({required this.p});

  @override
  Widget build(BuildContext context) {
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
          _summaryRow(p, 'Package', '\$1,104 × 2'),
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
                '\$2,208',
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
                  child: Column(
                    children: [
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
                            '\$2,208',
                            style: TextStyle(
                              fontSize: 18,
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
                      const SizedBox(height: 14),
                      SizedBox(
                        width: 118.97,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Secure payment via Stripe',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'lao-mn',
                          color: p.textMuted,
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
