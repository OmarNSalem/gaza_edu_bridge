import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand / Main Palette
  static const Color primary = Color(0xFF1A1A1A);
  static const Color primaryDark = Color(0xFF000000);
  static const Color background = Color(0xFFF8FAF9);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFEBF2EE);
  static const Color border = Color(0xFFC5DACC);
  static const Color mutedText = Color(0xFF6B7C72);
  static const Color foregroundText = Color(0xFF1A1A1A);

  // Subject Accents (Pixel-perfect from Figma/Web)
  static const Color arabicAccent = Color(0xFF7C3AED);
  static const Color scienceAccent = Color(0xFF1F6FEB);
  static const Color englishAccent = Color(0xFFF0883E);
  static const Color chemistryAccent = Color(0xFFEF4444);
  static const Color historyAccent = Color(0xFFE3B341);

  // Status & Badges
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2A2A2A), Color(0xFF000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [Color(0xFFE8E8E8), Color(0xFFF5F5F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
