import 'package:flutter/material.dart';

/// Extensions مفيدة على BuildContext
extension ContextExtensions on BuildContext {
  // ─── Theme ────────────────────────────────────────────
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // ─── Media Query ─────────────────────────────────────
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  double get topPadding => MediaQuery.paddingOf(this).top;

  // ─── Navigation ──────────────────────────────────────
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}
