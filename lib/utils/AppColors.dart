import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B0F1A);
  static const Color field = Color(0xFF1B2133);
  static const Color mutedText = Color(0xFF8A93A8);
  static const Color hintText = Color(0xFF6E7791);
  static const Color accentYellow = Color(0xFFF5B942);
  static const Color orangeStart = Color(0xFFFF8A5B);
  static const Color orangeEnd = Color(0xFFFF6B4A);

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [orangeStart, orangeEnd],
  );
}
