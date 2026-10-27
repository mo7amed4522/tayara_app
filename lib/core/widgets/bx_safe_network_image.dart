import 'package:flutter/material.dart';

class BxSafeNetworkImage extends StatelessWidget {
  const BxSafeNetworkImage({
    super.key,
    required this.url,
    required this.fallbackAsset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.image_not_supported_outlined,
    this.circular = false,
  });

  final String? url;
  final String fallbackAsset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData fallbackIcon;
  final bool circular;

  bool get _isRemote =>
      url != null && url!.isNotEmpty && url!.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget fallbackWidget = Image.asset(
      fallbackAsset,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, _, _) => Container(
        width: width,
        height: height,
        color: cs.surface,
        alignment: Alignment.center,
        child: Icon(
          fallbackIcon,
          size: 24,
          color: cs.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );

    Widget child = _isRemote
        ? Image.network(
            url!,
            width: width,
            height: height,
            fit: fit,
            // Suppress the noisy "EXCEPTION CAUGHT BY IMAGE RESOURCE SERVICE"
            // log that Flutter prints for every failed image request.
            errorBuilder: (_, _, _) => fallbackWidget,
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                width: width,
                height: height,
                color: cs.surface,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
          )
        : fallbackWidget;

    if (circular) {
      child = ClipOval(child: child);
    }
    return child;
  }
}
