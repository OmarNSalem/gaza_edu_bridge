import 'package:flutter/material.dart';

/// Border Radius الثابتة — مستخرجة من تصميم Figma بدقة تامة
abstract final class AppBorderRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;

  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius extraLargeRadius = BorderRadius.all(Radius.circular(xl));
}
