import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double blurAmount;
  final BorderRadius borderRadius;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.blurAmount = 12.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.secondarySurface.withOpacity(0.6),
              borderRadius: borderRadius,
              border: Border.all(
                // ignore: deprecated_member_use
                color: borderColor ?? AppColors.cardBorder.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
