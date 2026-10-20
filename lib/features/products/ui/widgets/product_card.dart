import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_network_image.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showRating = false,
  });

  final ProductModel product;
  final VoidCallback onTap;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    final radius = AppScale.radius(AppRadius.sm);
    final discountPercent = product.discountPercentage.round();

    return Material(
      color: AppColors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(
          color: AppColors.border,
          width: AppSizes.borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppScale.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: radius,
                  child: AppNetworkImage(
                    url: product.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppScale.gh(AppSpacing.xs),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body.bold,
              ),
              if (showRating) ...[
                AppScale.gh(AppSpacing.xxs),
                _RatingStars(rating: product.rating),
              ],
              AppScale.gh(AppSpacing.xs),
              const Spacer(),
              Text(
                product.discountedPrice.asPrice,
                style: AppTextStyles.body.bold.primary,
              ),
              if (discountPercent > 0) ...[
                AppScale.gh(AppSpacing.xxs),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.price.asPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.secondary.lineThrough,
                      ),
                    ),
                    AppScale.gw(AppSpacing.xs),
                    Text(
                      context.l10n.discountOff(discountPercent),
                      style: AppTextStyles.caption.bold.withColor(
                        AppColors.discount,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.rating});

  static const int _maxStars = 5;

  final double rating;

  @override
  Widget build(BuildContext context) {
    final filledStars = rating.round();

    return Row(
      children: [
        for (var star = 0; star < _maxStars; star++)
          Icon(
            Icons.star_rounded,
            size: AppScale.s(AppSizes.iconXs),
            color: star < filledStars ? AppColors.rating : AppColors.border,
          ),
      ],
    );
  }
}
