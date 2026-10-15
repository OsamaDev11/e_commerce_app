import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/features/cart/data/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Container(
      padding: AppScale.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppScale.radius(AppRadius.lg),
      ),
      child: Row(
        children: [
          Image.asset(
            product.imageAsset,
            width: AppScale.s(AppSizes.thumbnail),
            height: AppScale.s(AppSizes.thumbnail),
            fit: BoxFit.contain,
          ),
          AppScale.gw(AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.semiBold,
                      ),
                    ),
                    AppScale.gw(AppSpacing.xs),
                    AppIconButton(
                      iconPath: AppAssets.icons.remove,
                      onPressed: onRemove,
                      size: AppSizes.iconButtonSm,
                      iconSize: AppSizes.iconButtonSm,
                      backgroundColor: Colors.transparent,
                      radius: AppRadius.sm,
                    ),
                  ],
                ),
                AppScale.gh(AppSpacing.xxs),
                Text(
                  product.price.asPrice,
                  style: AppTextStyles.body.bold.primary,
                ),
                AppScale.gh(AppSpacing.sm),
                Row(
                  children: [
                    _QuantitySelector(
                      quantity: item.quantity,
                      onIncrease: onIncrease,
                      onDecrease: onDecrease,
                    ),
                    const Spacer(),
                    Text(
                      (product.price * item.quantity).asPrice,
                      style: AppTextStyles.bodySm.semiBold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIconButton(
          icon: Icons.remove_rounded,
          iconColor: AppColors.textSecondary,
          onPressed: onDecrease,
          size: AppSizes.iconButtonSm,
          iconSize: AppSizes.iconSm,
          radius: AppRadius.sm,
        ),
        SizedBox(
          width: AppScale.s(AppSizes.quantityLabel),
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.semiBold,
          ),
        ),
        AppIconButton(
          icon: Icons.add_rounded,
          iconColor: AppColors.primary,
          onPressed: onIncrease,
          size: AppSizes.iconButtonSm,
          iconSize: AppSizes.iconSm,
          radius: AppRadius.sm,
        ),
      ],
    );
  }
}
