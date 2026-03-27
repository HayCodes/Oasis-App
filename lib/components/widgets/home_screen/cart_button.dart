import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/home_screen/cart_drawer.dart';

class Cartbutton extends StatelessWidget {
  const Cartbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CartDrawer.show(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 22,
            color: AppColors.textPrimary,
          ),
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: AppColors.buttonPrimary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '3',
                  style: GoogleFonts.inter(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
