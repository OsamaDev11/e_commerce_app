import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF40BFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryShadow = Color(0x3D40BFFF);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF223263);
  static const Color textSecondary = Color(0xFF9098B1);

  static const Color neutralLight = Color(0xFFEBF0FF);
  static const Color border = neutralLight;

  static const Color error = Color(0xFFFB7181);
  static const Color discount = error;
  static const Color rating = Color(0xFFFFC833);
}
