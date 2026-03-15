import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.inputBorder, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            Icons.home_outlined,
            Icons.home_rounded,
            'Home',
            0,
            RouteNames.home,
          ),
          _buildNavItem(
            Icons.shopping_bag_outlined,
            Icons.shopping_bag_rounded,
            'Shop',
            1,
            RouteNames.shop,
          ),
          _buildNavItem(
            Icons.book_online_outlined,
            Icons.book_online_rounded,
            'Blog',
            2,
            RouteNames.support,
          ),
          _buildNavItem(
            Icons.person_outline,
            Icons.person_rounded,
            'Profile',
            3,
            RouteNames.support,
          ),
        ],
      ),
    );
  }

  int _selectedNav = 0;

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
    String route,
  ) {
    final isSelected = _selectedNav == index;
    void goToRoute(int index, String route) {
      setState(() {
        _selectedNav = index;
      });
      GoRouter.of(context).pushNamed(route);
    }

    return GestureDetector(
      onTap: () => goToRoute(index, route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            size: 22,
            color: isSelected ? AppColors.buttonPrimary : AppColors.textMuted,
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.jost(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.accent : AppColors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
