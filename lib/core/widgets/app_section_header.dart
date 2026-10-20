import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppScale.symmetric(horizontal: AppSpacing.page),
      child: Text(title, style: AppTextStyles.subtitle),
    );
  }
}
