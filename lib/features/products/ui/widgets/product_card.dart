import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/features/products/data/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  static const double maxWidth = 200;
  static const double aspectRatio = 0.68;

  final ProductModel product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppScale.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppScale.radius(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                product.imageAsset,
                width: AppScale.s(AppSizes.productImage),
                height: AppScale.s(AppSizes.productImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
          AppScale.gh(AppSpacing.sm),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.semiBold,
          ),
          AppScale.gh(AppSpacing.xxs),
          Text(
            product.price.asPrice,
            style: AppTextStyles.body.bold.primary,
          ),
          AppScale.gh(AppSpacing.xs),
          AppPrimaryButton(
            label: context.l10n.addToCart,
            icon: Icons.add_rounded,
            compact: true,
            onPressed: onAddToCart,
          ),
        ],
      ),
    );
  }
}
