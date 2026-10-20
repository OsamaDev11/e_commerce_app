import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.slug});

  final String slug;

  static const Map<String, IconData> _icons = {
    'beauty': Icons.face_retouching_natural_outlined,
    'fragrances': Icons.spa_outlined,
    'furniture': Icons.chair_outlined,
    'groceries': Icons.local_grocery_store_outlined,
    'home-decoration': Icons.home_outlined,
    'kitchen-accessories': Icons.kitchen_outlined,
    'laptops': Icons.laptop_outlined,
    'mens-shirts': Icons.checkroom_outlined,
    'mens-shoes': Icons.directions_run_outlined,
    'mens-watches': Icons.watch_outlined,
    'mobile-accessories': Icons.headphones_outlined,
    'motorcycle': Icons.two_wheeler_outlined,
    'skin-care': Icons.clean_hands_outlined,
    'smartphones': Icons.smartphone_outlined,
    'sports-accessories': Icons.sports_basketball_outlined,
    'sunglasses': Icons.wb_sunny_outlined,
    'tablets': Icons.tablet_android_outlined,
    'tops': Icons.checkroom_outlined,
    'vehicle': Icons.directions_car_outlined,
    'womens-bags': Icons.shopping_bag_outlined,
    'womens-dresses': Icons.checkroom_outlined,
    'womens-jewellery': Icons.diamond_outlined,
    'womens-shoes': Icons.directions_run_outlined,
    'womens-watches': Icons.watch_outlined,
  };

  String get _label {
    return slug
        .split('-')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppScale.s(AppSizes.categoryItem);

    return SizedBox(
      width: size,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.border,
                width: AppSizes.borderWidth,
              ),
            ),
            child: Icon(
              _icons[slug] ?? Icons.category_outlined,
              size: AppScale.s(AppSizes.iconMd),
              color: AppColors.primary,
            ),
          ),
          AppScale.gh(AppSpacing.xs),
          Text(
            _label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.secondary,
          ),
        ],
      ),
    );
  }
}
