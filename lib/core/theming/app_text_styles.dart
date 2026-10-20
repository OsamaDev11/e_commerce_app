import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Poppins';

  static const double _letterSpacing = 0.5;

  static TextStyle _style(double size, {FontWeight weight = FontWeight.w400}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: AppScale.sp(size),
      fontWeight: weight,
      height: 1.5,
      letterSpacing: _letterSpacing,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle get title => _style(16, weight: FontWeight.w700);

  static TextStyle get subtitle => _style(14, weight: FontWeight.w700);

  static TextStyle get body => _style(12);

  static TextStyle get caption => _style(10);
}

extension AppTextStyleX on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get secondary => copyWith(color: AppColors.textSecondary);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get onPrimary => copyWith(color: AppColors.onPrimary);

  TextStyle get lineThrough => copyWith(
        decoration: TextDecoration.lineThrough,
        decorationColor: color,
      );

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withHeight(double height) => copyWith(height: height);
}
