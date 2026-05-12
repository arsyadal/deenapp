import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:deenapp/core/theme/app_colors.dart';
import 'package:deenapp/features/prayer/models/prayer_time.dart';
import 'package:deenapp/shared/widgets/glass_card.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard({
    super.key,
    required this.prayer,
    this.isNext = false,
  });

  final PrayerTime prayer;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderColor: isNext ? AppColors.accentGlow : null,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // Prayer name and Arabic name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prayer.name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: isNext ? FontWeight.w600 : FontWeight.w500,
                    color: isNext
                        ? AppColors.accentGlow
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  prayer.arabicName,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Formatted time
          Text(
            prayer.formattedTime,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isNext ? AppColors.accentGlow : AppColors.textPrimary,
            ),
          ),
          if (isNext) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accentGlow,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
