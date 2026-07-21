import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_border_radius.dart';

/// الثيم الكامل للتطبيق — Dark Mode فقط كما هو في التصميم
abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,

      // ─── Color Scheme ──────────────────────────────────
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.levelMiddle,
        onSecondary: Colors.white,
        surface: AppColors.card,
        onSurface: AppColors.foreground,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.border,
        surfaceContainerHighest: AppColors.surfaceAccent,
      ),

      // ─── Scaffold ──────────────────────────────────────
      scaffoldBackgroundColor: AppColors.background,

      // ─── AppBar ────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.foreground,
        ),
      ),

      // ─── Card ──────────────────────────────────────────
      cardTheme: const CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.largeRadius,
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ─── ElevatedButton ────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.largeRadius,
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // ─── OutlinedButton ────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.foreground,
          side: const BorderSide(color: AppColors.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorderRadius.largeRadius,
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // ─── TextButton ────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
        ),
      ),

      // ─── InputDecoration ───────────────────────────────
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.largeRadius,
          borderSide: BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.largeRadius,
          borderSide: BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.largeRadius,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.largeRadius,
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.largeRadius,
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      // ─── BottomNavigationBar ───────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.mutedForeground,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ─── Chip ──────────────────────────────────────────
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.surfaceAccent,
        selectedColor: Color(0x332EA043), // primary با 0.2 opacity
        side: BorderSide(color: AppColors.border, width: 1),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.smallRadius,
        ),
      ),

      // ─── Divider ───────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // ─── SnackBar ──────────────────────────────────────
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surfaceAccent,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.mediumRadius,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ─── Dialog ────────────────────────────────────────
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.extraLargeRadius,
        ),
      ),

      // ─── Text ──────────────────────────────────────────
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display.copyWith(color: AppColors.foreground),
        titleLarge: AppTextStyles.title.copyWith(color: AppColors.foreground),
        titleMedium: AppTextStyles.heading.copyWith(color: AppColors.foreground),
        bodyLarge: AppTextStyles.bodyBold.copyWith(color: AppColors.foreground),
        bodyMedium: AppTextStyles.body.copyWith(color: AppColors.foreground),
        bodySmall: AppTextStyles.caption.copyWith(color: AppColors.mutedForeground),
        labelSmall: AppTextStyles.mini.copyWith(color: AppColors.mutedForeground),
      ),
    );
  }
}
