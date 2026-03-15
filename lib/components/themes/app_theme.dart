import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Core
  static const Color black = Color(0xFF10101D);
  static const Color white = Colors.white;
  static const Color background = Color(0xFFF3F4F7);

  // Text
  static const Color textPrimary = Color(0xFF0D0D0D);
  static const Color textSecondary = Color(0xFF5F6980);
  static const Color accent = Color(0xFF7C71DF);
  static const Color accentLight = Color(0xFFD6BBFB);
  static const Color textMuted = Color(0xFFAAAAAA);
  static const Color tag = Color(0xFFF0EDEA);


  // Accent
  static const Color green = Color(0xFF2E7D32);
  static const Color greenLight = Color(0xFF43A047);
  static const Color red = Color(0xFFC62828);
  static const Color redLight = Color(0xFFF65061);
  static const Color blue = Color(0xFF1565C0);
  static const Color blueLight = Color(0xFFE3F2FD);

  // Button
  static const Color buttonPrimary = Color(0xFF7C71DF);
  static const Color buttonPrimaryLight = Color(0xFFD6BBFB);
  static const Color buttonSecondary = Color(0xFFF8F7FB);
  static const Color buttonSecondaryLight = Color(0xFFE3F2FD);


  // Input
  static const Color inputBorder = Color(0xFFBABBC1);
  static const Color inputFill = Color(0xFFF8F8F8);

}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        surface: AppColors.white,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w200,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cormorant(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          letterSpacing: 1.5,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.inputBorder,
        thickness: 1,
      ),
    );
  }
}
