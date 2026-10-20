import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';

abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 28;
  static const double xxl = 32;

  static const double page = md;
}

abstract final class AppRadius {
  static const double sm = 5;
  static const double lg = 16;
}

abstract final class AppSizes {
  static const double buttonHeight = 57;
  static const double iconButton = 40;
  static const double iconButtonSm = 32;

  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconXl = 56;

  static const double logo = 72;
  static const double logoMark = 26;
  static const double logoMarkCore = 10;

  static const double badge = 16;
  static const double categoryItem = 70;
  static const double productCard = 141;
  static const double thumbnail = 72;

  static const double quantityHeight = 24;
  static const double quantityButtonWidth = 32;
  static const double quantityLabelWidth = 40;

  static const double dashLength = 4;
  static const double borderWidth = 1;
  static const double loaderStroke = 2;
}

abstract final class AppShadows {
  static List<BoxShadow> get primaryButton => [
        BoxShadow(
          color: AppColors.primaryShadow,
          offset: Offset(0, AppScale.s(10)),
          blurRadius: AppScale.s(30),
        ),
      ];
}
