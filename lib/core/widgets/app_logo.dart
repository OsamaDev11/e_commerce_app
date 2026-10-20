import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppScale.s(AppSizes.logo),
      height: AppScale.s(AppSizes.logo),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppScale.radius(AppRadius.lg),
      ),
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: AppScale.s(AppSizes.logoMark),
          height: AppScale.s(AppSizes.logoMark),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: AppScale.radius(AppRadius.sm),
          ),
          child: Container(
            width: AppScale.s(AppSizes.logoMarkCore),
            height: AppScale.s(AppSizes.logoMarkCore),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppScale.radius(AppSizes.borderWidth),
            ),
          ),
        ),
      ),
    );
  }
}
