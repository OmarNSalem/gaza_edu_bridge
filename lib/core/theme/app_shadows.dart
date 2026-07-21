import 'package:flutter/material.dart';

// الظلال — مستخرجة من تصميم Figma بدقة تامة
abstract final class AppShadows {
  // ظل البطاقة العادية
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x4D000000), // rgba(0,0,0,0.3)
      blurRadius: 8,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];

  // ظل ثقيل للـ modals وبطاقات بارزة
  static const List<BoxShadow> heavy = [
    BoxShadow(
      color: Color(0x80000000), // rgba(0,0,0,0.5)
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  // توهج أخضر للشعار والعناصر الرئيسية
  static const List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: Color(0x332EA043), // rgba(46,160,67,0.2)
      blurRadius: 32,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];
}
