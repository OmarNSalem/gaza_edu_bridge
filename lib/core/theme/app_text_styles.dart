import 'package:flutter/material.dart';

/// أنماط النصوص — مستخرجة من تصميم Figma بدقة تامة
abstract final class AppTextStyles {
  // ─── Font Family ─────────────────────────────────────
  static const String fontFamily = 'Tajawal';

  // ─── Display ─────────────────────────────────────────
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700, // Bold
    height: 1.3,
    letterSpacing: -0.5,
  );

  // ─── Title ───────────────────────────────────────────
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700, // Bold
    height: 1.4,
    letterSpacing: -0.3,
  );

  // ─── Heading ─────────────────────────────────────────
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w700, // Bold
    height: 1.4,
    letterSpacing: -0.2,
  );

  // ─── Body ────────────────────────────────────────────
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5,
    letterSpacing: 0,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500, // Medium
    height: 1.5,
    letterSpacing: 0,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700, // Bold
    height: 1.5,
    letterSpacing: 0,
  );

  // ─── Caption ─────────────────────────────────────────
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle captionMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle captionBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700, // Bold
    height: 1.4,
    letterSpacing: 0.1,
  );

  // ─── Mini ────────────────────────────────────────────
  static const TextStyle mini = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400, // Regular
    height: 1.3,
    letterSpacing: 0.2,
  );

  static const TextStyle miniBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700, // Bold
    height: 1.3,
    letterSpacing: 0.2,
  );

  // ─── Button ──────────────────────────────────────────
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.2,
    letterSpacing: 0.1,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500, // Medium
    height: 1.2,
    letterSpacing: 0.1,
  );
}
