import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:deenapp/core/theme/app_colors.dart';
import 'package:deenapp/features/zikir/models/zikir.dart';
import 'package:deenapp/features/zikir/providers/zikir_provider.dart';
import 'package:deenapp/features/zikir/widgets/zikir_counter.dart';

class ZikirScreen extends StatelessWidget {
  const ZikirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        appBar: AppBar(
          title: const Text('Zikir'),
          backgroundColor: AppColors.primaryBg,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
              onPressed: () {
                context.read<ZikirProvider>().resetAll();
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: AppColors.accentGlow,
            labelColor: AppColors.accentGlow,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              Tab(text: 'Post-Salat'),
              Tab(text: 'Morning'),
              Tab(text: 'Evening'),
            ],
          ),
        ),
        body: Consumer<ZikirProvider>(
          builder: (context, zikirProvider, _) {
            return Column(
              children: [
                // Overall progress
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: zikirProvider.totalProgress,
                            backgroundColor:
                                AppColors.accentGlow.withOpacity(0.15),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.accentGlow,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(zikirProvider.totalProgress * 100).toInt()}%',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentGlow,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${zikirProvider.completedCount}/${zikirProvider.zikirItems.length})',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tabs
                Expanded(
                  child: TabBarView(
                    children: [
                      _ZikirGrid(items: zikirProvider.postSalatItems),
                      _ZikirGrid(items: zikirProvider.morningItems),
                      _ZikirGrid(items: zikirProvider.eveningItems),
                    ],
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

class _ZikirGrid extends StatelessWidget {
  const _ZikirGrid({required this.items});

  final List<Zikir> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No zikir items',
          style: GoogleFonts.inter(color: AppColors.textSecondary),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final zikir = items[index];
        return ZikirCounter(
          zikir: zikir,
          onTap: () {
            context.read<ZikirProvider>().increment(zikir.id);
          },
        );
      },
    );
  }
}
