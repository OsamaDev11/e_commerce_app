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
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        titleLarge: AppTextStyles.title,
        titleMedium: AppTextStyles.subtitle,
        titleSmall: AppTextStyles.body.bold,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.subtitle,
        labelMedium: AppTextStyles.body,
        labelSmall: AppTextStyles.caption,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTextStyles.body.secondary,
        errorStyle: AppTextStyles.caption.withColor(AppColors.error),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        contentPadding: AppScale.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: _inputBorder(AppColors.border),
        enabledBorder: _inputBorder(AppColors.border),
        focusedBorder: _inputBorder(AppColors.primary),
        errorBorder: _inputBorder(AppColors.error),
        focusedErrorBorder: _inputBorder(AppColors.error),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.onPrimary,
          minimumSize: Size.fromHeight(AppScale.s(AppSizes.buttonHeight)),
          padding: AppScale.symmetric(horizontal: AppSpacing.md),
          textStyle: AppTextStyles.subtitle,
          shape: RoundedRectangleBorder(
            borderRadius: AppScale.radius(AppRadius.sm),
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
        contentTextStyle: AppTextStyles.body.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: AppScale.radius(AppRadius.sm),
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: AppScale.radius(AppRadius.sm),
      borderSide: BorderSide(color: color, width: AppSizes.borderWidth),
    );
  }
}
