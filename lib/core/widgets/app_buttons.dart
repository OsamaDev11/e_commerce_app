import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppScale.radius(AppRadius.sm),
        boxShadow: AppShadows.primaryButton,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox.square(
                dimension: AppScale.s(AppSizes.iconMd),
                child: const CircularProgressIndicator(
                  strokeWidth: AppSizes.loaderStroke,
                  color: AppColors.onPrimary,
                ),
              )
            : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );

    if (!expanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.textSecondary,
    this.size = AppSizes.iconButton,
    this.iconSize = AppSizes.iconMd,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox.square(
          dimension: AppScale.s(size),
          child: Icon(icon, size: AppScale.s(iconSize), color: color),
        ),
      ),
    );
  }
}
