import 'package:flutter/material.dart';

/// ألوان التطبيق — مستخرجة من تصميم Figma بدقة تامة
abstract final class AppColors {
  // ─── Primary Green (الأخضر الفلسطيني) ───────────────
  static const Color primary = Color(0xFF2EA043);
  static const Color primaryDark = Color(0xFF1C4A2A);
  static const Color primaryHover = Color(0xFF1A7A30);
  static const Color primaryLight = Color(0xFFC5DACC);
  static const Color primarySurface = Color(0xFFEBF2EE);

  // ─── Background & Surface ────────────────────────────
  static const Color background = Color(0xFF0D1117);
  static const Color card = Color(0xFF161B22);
  static const Color surfaceAccent = Color(0xFF1F242C);
  static const Color secondary = Color(0xFF21262D);

  // ─── Borders ─────────────────────────────────────────
  static const Color border = Color(0xFF30363D);
  static const Color borderLight = Color(0xFF21262D);

  // ─── Text ────────────────────────────────────────────
  static const Color foreground = Color(0xFFE6EDF3);
  static const Color mutedForeground = Color(0xFF7D8590);

  // ─── المراحل الدراسية ────────────────────────────────
  static const Color levelPrimary = Color(0xFF2EA043);
  static const Color levelMiddle = Color(0xFF1F6FEB);
  static const Color levelHigh = Color(0xFF7C3AED);

  // ─── المواد ──────────────────────────────────────────
  static const Color chemistry = Color(0xFFEF4444);
  static const Color history = Color(0xFFE3B341);
  static const Color english = Color(0xFFF0883E);

  // ─── States ──────────────────────────────────────────
  static const Color success = Color(0xFF2EA043);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFE3B341);
  static const Color info = Color(0xFF1F6FEB);

  // ─── Gradients ───────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2EA043), Color(0xFF1C4A2A)],
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2EA043), Color(0xFF1A7A30)],
  );
}
