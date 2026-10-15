import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = true,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expanded;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: compact
          ? ElevatedButton.styleFrom(
              minimumSize: Size(0, AppScale.s(AppSizes.buttonHeightSm)),
              padding: EdgeInsets.zero,
              textStyle: AppTextStyles.caption.semiBold,
              shape: RoundedRectangleBorder(
                borderRadius: AppScale.radius(AppRadius.sm),
              ),
            )
          : null,
      child: isLoading
          ? SizedBox.square(
              dimension: AppScale.s(AppSizes.iconMd),
              child: const CircularProgressIndicator(
                strokeWidth: AppSizes.loaderStroke,
                color: AppColors.onPrimary,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: AppScale.s(compact ? AppSizes.iconXs : AppSizes.iconMd),
                  ),
                  AppScale.gw(AppSpacing.xxs),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );

    if (!expanded) return button;

    return SizedBox(width: double.infinity, child: button);
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    this.iconPath,
    this.icon,
    this.iconColor,
    this.size = AppSizes.iconButton,
    this.iconSize = AppSizes.iconLg,
    this.backgroundColor = AppColors.surfaceMuted,
    this.radius = AppRadius.md,
  }) : assert(
          (iconPath == null) != (icon == null),
          'Provide either iconPath or icon.',
        );

  final VoidCallback? onPressed;
  final String? iconPath;
  final IconData? icon;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final iconPath = this.iconPath;
    final iconColor = this.iconColor;
    final dimension = AppScale.s(iconSize);

    final Widget child = iconPath != null
        ? SvgPicture.asset(
            iconPath,
            width: dimension,
            height: dimension,
            colorFilter: iconColor == null
                ? null
                : ColorFilter.mode(iconColor, BlendMode.srcIn),
          )
        : Icon(icon, size: dimension, color: iconColor);

    return Material(
      color: backgroundColor,
      borderRadius: AppScale.radius(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox.square(
          dimension: AppScale.s(size),
          child: Center(child: child),
        ),
      ),
    );
  }
}
