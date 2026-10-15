import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';

class AppPageFrame extends StatelessWidget {
  const AppPageFrame({
    super.key,
    required this.body,
    this.header,
    this.color = AppColors.surfaceMuted,
  });

  final Widget body;
  final Widget? header;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final header = this.header;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppScale.symmetric(
            horizontal: AppSpacing.pageMargin,
            vertical: AppSpacing.xxs,
          ),
          child: ClipRRect(
            borderRadius: AppScale.radius(AppRadius.xl),
            child: ColoredBox(
              color: color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (header != null)
                    ColoredBox(
                      color: AppColors.surface,
                      child: Padding(
                        padding: AppScale.symmetric(
                          horizontal: AppSpacing.pagePadding,
                          vertical: AppSpacing.xl,
                        ),
                        child: header,
                      ),
                    ),
                  Expanded(child: body),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
