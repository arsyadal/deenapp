import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:deenapp/core/theme/app_colors.dart';
import 'package:deenapp/features/auth/providers/auth_provider.dart';
import 'package:deenapp/features/prayer/providers/prayer_provider.dart';
import 'package:deenapp/features/zikir/providers/zikir_provider.dart';
import 'package:deenapp/features/zikir/screens/zikir_screen.dart';
import 'package:deenapp/shared/widgets/glass_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final prayerProvider = context.watch<PrayerProvider>();
    final zikirProvider = context.watch<ZikirProvider>();

    final userName = authProvider.user?.userMetadata?['full_name'] as String? ??
        authProvider.user?.email?.split('@').first ??
        'User';

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        title: const Text('DeenApp'),
        backgroundColor: AppColors.primaryBg,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Row 1: Greeting + Quick action
            Row(
              children: [
                // Greeting card
                Expanded(
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting(),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userName,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Quick action to zikir
                GlassCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ZikirScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const Icon(
                        Icons.touch_app_outlined,
                        color: AppColors.accentGlow,
                        size: 28,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Zikir',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 2: Next prayer countdown (large card)
            GlassCard(
              borderColor: prayerProvider.nextPrayer != null
                  ? AppColors.accentGlow.withOpacity(0.3)
                  : null,
              child: prayerProvider.prayerTimes.isNotEmpty
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Next Prayer',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (prayerProvider.nextPrayer != null)
                              Text(
                                prayerProvider.nextPrayer!.name,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accentGlow,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          prayerProvider.countdownFormatted,
                          style: GoogleFonts.inter(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentGlow,
                            letterSpacing: 2,
                          ),
                        ),
                        if (prayerProvider.nextPrayer != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            prayerProvider.nextPrayer!.formattedTime,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    )
                  : Center(
                      child: Text(
                        'Fetching prayer times...',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),

            // Row 3: Zikir progress
            GlassCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ZikirScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  // Progress ring
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: zikirProvider.totalProgress,
                          strokeWidth: 4,
                          backgroundColor:
                              AppColors.accentGlow.withOpacity(0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accentGlow,
                          ),
                        ),
                        Text(
                          '${(zikirProvider.totalProgress * 100).toInt()}%',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentGlow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Zikir Progress',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${zikirProvider.completedCount} of ${zikirProvider.zikirItems.length} completed',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Assalamu Alaikum';
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
