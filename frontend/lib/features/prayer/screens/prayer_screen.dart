import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:deenapp/core/theme/app_colors.dart';
import 'package:deenapp/features/prayer/providers/prayer_provider.dart';
import 'package:deenapp/features/prayer/widgets/prayer_card.dart';
import 'package:deenapp/shared/widgets/glass_card.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        title: const Text('Prayer Times'),
        backgroundColor: AppColors.primaryBg,
        elevation: 0,
      ),
      body: Consumer<PrayerProvider>(
        builder: (context, prayerProvider, _) {
          if (prayerProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.accentGlow,
              ),
            );
          }

          if (prayerProvider.errorMessage != null) {
            return Center(
              child: Text(
                prayerProvider.errorMessage!,
                style: GoogleFonts.inter(color: AppColors.textSecondary),
              ),
            );
          }

          if (prayerProvider.prayerTimes.isEmpty) {
            return Center(
              child: Text(
                'No prayer times available',
                style: GoogleFonts.inter(color: AppColors.textSecondary),
              ),
            );
          }

          final nextPrayer = prayerProvider.nextPrayer;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // City name and Hijri date
              if (prayerProvider.cityName.isNotEmpty ||
                  prayerProvider.hijriDate.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (prayerProvider.cityName.isNotEmpty)
                        Text(
                          prayerProvider.cityName,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      if (prayerProvider.hijriDate.isNotEmpty)
                        Text(
                          prayerProvider.hijriDate,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),

              // Next prayer countdown
              if (nextPrayer != null) ...[
                GlassCard(
                  borderColor: AppColors.accentGlow.withOpacity(0.3),
                  child: Column(
                    children: [
                      Text(
                        'Next: ${nextPrayer.name}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        prayerProvider.countdownFormatted,
                        style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentGlow,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Prayer list
              ...prayerProvider.prayerTimes.map((prayer) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PrayerCard(
                    prayer: prayer,
                    isNext: nextPrayer?.name == prayer.name,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
