import 'package:flutter/material.dart';

abstract class AppShadows {
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x0A000000), // opacity 4%
    blurRadius: 10,
    spreadRadius: 0,
    offset: Offset(0, 4),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x1A000000), // opacity 10%
    blurRadius: 8,
    spreadRadius: 0,
    offset: Offset(0, 2),
  );
}
