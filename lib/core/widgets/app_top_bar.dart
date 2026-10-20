import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions = const [],
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final onBack = this.onBack;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: AppScale.symmetric(
            horizontal: AppSpacing.page,
            vertical: AppSpacing.xs,
          ),
          child: SizedBox(
            height: AppScale.s(AppSizes.iconButton),
            child: Row(
              children: [
                if (onBack != null) ...[
                  AppIconButton(
                    icon: Icons.chevron_left_rounded,
                    onPressed: onBack,
                  ),
                  AppScale.gw(AppSpacing.xxs),
                ],
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title,
                  ),
                ),
                ...actions,
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
