import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/components/themes/app_theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  static const _labels = ['Home', 'Shop', 'Blog', 'Categories'];

  static const _icons = [
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
    Icons.book_online_outlined,
    Icons.category_outlined,
  ];

  static const _activeIcons = [
    Icons.home_rounded,
    Icons.shopping_bag_rounded,
    Icons.book_online_rounded,
    Icons.category_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.inputBorder)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_labels.length, (i) {
            final isSelected = navigationShell.currentIndex == i;
            return GestureDetector(
              onTap: () =>
                  navigationShell.goBranch(
                    i,
                    initialLocation: i == navigationShell.currentIndex,
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? _activeIcons[i] : _icons[i],
                    size: 22,
                    color: isSelected
                        ? AppColors.buttonPrimary
                        : AppColors.textMuted,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _labels[i].toUpperCase(),
                    style: GoogleFonts.jost(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.accent : AppColors
                          .textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}