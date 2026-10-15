import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle _style(
    double size, {
    FontWeight weight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      fontSize: AppScale.sp(size),
      fontWeight: weight,
      height: height,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get h1 => _style(24, weight: FontWeight.w700, height: 1.2);

  static TextStyle get h2 => _style(18, weight: FontWeight.w700);

  static TextStyle get bodyLg => _style(14);

  static TextStyle get body => _style(13);

  static TextStyle get bodySm => _style(12);

  static TextStyle get caption => _style(11);
}

extension AppTextStyleX on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get secondary => copyWith(color: AppColors.textSecondary);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get onPrimary => copyWith(color: AppColors.onPrimary);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withHeight(double height) => copyWith(height: height);
}
