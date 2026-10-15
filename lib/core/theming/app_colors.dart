import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF2457F5);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primarySoft = Color(0xFFE8EEFF);
  static const Color primarySoftFaded = Color(0x99E8EEFF);

  static const Color background = Color(0xFFEEF2F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF8FAFC);

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF6C6D6F);

  static const Color inputBackground = surfaceMuted;
  static const Color border = Color(0xFFF1F5F9);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}
