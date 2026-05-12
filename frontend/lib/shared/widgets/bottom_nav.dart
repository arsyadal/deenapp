import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryBg,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder, width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.primaryBg,
        selectedItemColor: AppColors.accentGlow,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Prayer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Zikir',
          ),
        ],
      ),
    );
  }
}
