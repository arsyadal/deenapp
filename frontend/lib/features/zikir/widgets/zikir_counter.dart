import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:deenapp/core/theme/app_colors.dart';
import 'package:deenapp/features/zikir/models/zikir.dart';

class ZikirCounter extends StatefulWidget {
  const ZikirCounter({
    super.key,
    required this.zikir,
    required this.onTap,
  });

  final Zikir zikir;
  final VoidCallback onTap;

  @override
  State<ZikirCounter> createState() => _ZikirCounterState();
}

class _ZikirCounterState extends State<ZikirCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _scaleController.forward().then((_) => _scaleController.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final zikir = widget.zikir;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondarySurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: zikir.isCompleted
                  ? AppColors.accentGlow.withOpacity(0.5)
                  : AppColors.cardBorder,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Progress ring with count
              SizedBox(
                width: 72,
                height: 72,
                child: CustomPaint(
                  painter: _ProgressRingPainter(
                    progress: zikir.progress,
                    ringColor: AppColors.accentGlow,
                    bgColor: AppColors.secondarySurface,
                  ),
                  child: Center(
                    child: Text(
                      '${zikir.current}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: zikir.isCompleted
                            ? AppColors.accentGlow
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Zikir name
              Text(
                zikir.name,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              // Target
              Text(
                '${zikir.current}/${zikir.target}',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.ringColor,
    required this.bgColor,
  });

  final double progress;
  final Color ringColor;
  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 4.0;

    // Background ring
    final bgPaint = Paint()
      ..color = ringColor.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
