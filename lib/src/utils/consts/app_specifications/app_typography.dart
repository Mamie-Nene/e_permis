import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  static TextTheme textTheme = GoogleFonts.manropeTextTheme().copyWith(
    displayLarge: GoogleFonts.manrope(
      fontSize: 54,
      fontWeight: FontWeight.w600,
      letterSpacing: -1,
      color: AppColors.onBackground,
    ),
    headlineLarge: GoogleFonts.manrope(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    headlineMedium: GoogleFonts.manrope(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    headlineSmall: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    titleLarge: GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onBackground,
    ),
    titleSmall: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.onBackground,
    ),
    bodyLarge: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
    ),
    bodySmall: GoogleFonts.manrope(
      fontSize: 14,
      color: AppColors.onSurface.withOpacity(.7),
    ),
    labelLarge: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
      letterSpacing: .3,
    ),
    labelMedium: GoogleFonts.manrope(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    labelSmall: GoogleFonts.manrope(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: .8,
      color: AppColors.onSurface,
    ),
  );
}

