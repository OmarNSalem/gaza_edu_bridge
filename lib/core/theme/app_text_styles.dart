import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle get headerTitle => GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.foregroundText,
      );

  static TextStyle get sectionTitle => GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.foregroundText,
      );

  static TextStyle get cardTitle => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.foregroundText,
      );

  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.foregroundText,
      );

  static TextStyle get bodySmall => GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.mutedText,
      );

  static TextStyle get badgeText => GoogleFonts.cairo(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.mutedText,
      );

  static TextStyle get buttonText => GoogleFonts.cairo(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
}
