import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_network_image.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';

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
    final radius = AppScale.radius(AppRadius.sm);

    return Container(
      padding: AppScale.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(
          color: AppColors.border,
          width: AppSizes.borderWidth,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: radius,
            child: AppNetworkImage(
              url: product.thumbnail,
              width: AppScale.s(AppSizes.thumbnail),
              height: AppScale.s(AppSizes.thumbnail),
              fit: BoxFit.cover,
            ),
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
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.bold,
                      ),
                    ),
                    AppScale.gw(AppSpacing.xs),
                    AppIconButton(
                      icon: Icons.delete_outline_rounded,
                      size: AppSizes.iconButtonSm,
                      onPressed: onRemove,
                    ),
                  ],
                ),
                AppScale.gh(AppSpacing.xs),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.discountedPrice.asPrice,
                        style: AppTextStyles.body.bold.primary,
                      ),
                    ),
                    _QuantitySelector(
                      quantity: item.quantity,
                      onIncrease: onIncrease,
                      onDecrease: onDecrease,
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
    final radius = AppScale.radius(AppRadius.sm);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(
          color: AppColors.border,
          width: AppSizes.borderWidth,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _QuantityButton(icon: Icons.remove_rounded, onTap: onDecrease),
            Container(
              constraints: BoxConstraints(
                minWidth: AppScale.s(AppSizes.quantityLabelWidth),
                minHeight: AppScale.s(AppSizes.quantityHeight),
              ),
              alignment: Alignment.center,
              color: AppColors.neutralLight,
              child: Text('$quantity', style: AppTextStyles.body),
            ),
            _QuantityButton(icon: Icons.add_rounded, onTap: onIncrease),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: AppScale.s(AppSizes.quantityButtonWidth),
          minHeight: AppScale.s(AppSizes.quantityHeight),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: AppScale.s(AppSizes.iconSm),
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
