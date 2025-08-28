import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/fonts.dart';
import '../core/lang/english.dart';
import '../core/lang/french.dart';
import 'package:provider/provider.dart';
import '../providers/language.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final eng = English();
  final fr = French();
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 80,
          decoration: BoxDecoration(color: const Color(0xFF131313)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: provider.locale.languageCode == 'fr'
                    ? fr.navbarItems[0]
                    : eng.navbarItems[0],
                index: 0,
                isSelected: currentIndex == 0,
              ),
              _buildNavItem(
                icon: Icons.fitness_center_rounded,
                label: provider.locale.languageCode == 'fr'
                    ? fr.navbarItems[1]
                    : eng.navbarItems[1],
                index: 1,
                isSelected: currentIndex == 1,
              ),
              _buildNavItem(
                icon: Icons.flag_rounded,
                label: provider.locale.languageCode == 'fr'
                    ? fr.navbarItems[2]
                    : eng.navbarItems[2],
                index: 2,
                isSelected: currentIndex == 2,
              ),
              _buildNavItem(
                icon: Icons.trending_up_rounded,
                label: provider.locale.languageCode == 'fr'
                    ? fr.navbarItems[3]
                    : eng.navbarItems[3],
                index: 3,
                isSelected: currentIndex == 3,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primaryColor : Colors.grey[400],
                size: isSelected ? 28 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Fonts.text.copyWith(
                color: isSelected ? AppColors.primaryColor : Colors.grey[400],
                fontSize: isSelected ? 12 : 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
