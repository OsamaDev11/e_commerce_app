import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        headlineMedium: AppTextStyles.h1,
        titleLarge: AppTextStyles.h2,
        titleMedium: AppTextStyles.bodyLg.semiBold,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.bodyLg.semiBold,
        labelMedium: AppTextStyles.bodySm,
        labelSmall: AppTextStyles.caption,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: AppTextStyles.body.secondary,
        errorStyle: AppTextStyles.caption.withColor(AppColors.error),
        contentPadding: AppScale.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: _inputBorder(AppColors.border, AppSizes.borderWidth),
        enabledBorder: _inputBorder(AppColors.border, AppSizes.borderWidth),
        focusedBorder: _inputBorder(
          AppColors.primary,
          AppSizes.focusedBorderWidth,
        ),
        errorBorder: _inputBorder(AppColors.error, AppSizes.borderWidth),
        focusedErrorBorder: _inputBorder(
          AppColors.error,
          AppSizes.focusedBorderWidth,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.onPrimary,
          minimumSize: Size(
            AppScale.s(AppSizes.buttonHeight),
            AppScale.s(AppSizes.buttonHeight),
          ),
          padding: AppScale.symmetric(horizontal: AppSpacing.lg),
          textStyle: AppTextStyles.bodyLg.semiBold,
          shape: RoundedRectangleBorder(
            borderRadius: AppScale.radius(AppRadius.md),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: AppSizes.borderWidth,
        space: AppSizes.borderWidth,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTextStyles.bodySm.medium.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: AppScale.radius(AppRadius.md),
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: AppScale.radius(AppRadius.md),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
