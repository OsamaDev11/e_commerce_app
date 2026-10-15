import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_page_frame.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/products/data/demo_products.dart';
import 'package:e_commerce_app/features/products/ui/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final products = DemoProducts.products;

    return AppPageFrame(
      header: const _HomeHeader(),
      body: SingleChildScrollView(
        padding: AppScale.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.featured, style: AppTextStyles.h2),
            AppScale.gh(AppSpacing.xxs),
            Text(
              l10n.productsCount(products.length),
              style: AppTextStyles.bodySm.secondary,
            ),
            AppScale.gh(AppSpacing.lg),
            GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: AppScale.s(ProductCard.maxWidth),
                crossAxisSpacing: AppScale.s(AppSpacing.sm),
                mainAxisSpacing: AppScale.s(AppSpacing.md),
                childAspectRatio: ProductCard.aspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onAddToCart: () =>
                      context.read<CartCubit>().addProduct(product),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.goodMorning, style: AppTextStyles.bodySm.secondary),
              AppScale.gh(AppSpacing.xxs),
              Text(l10n.discoverProducts, style: AppTextStyles.h1),
            ],
          ),
        ),
        AppScale.gw(AppSpacing.sm),
        const _CartButton(),
      ],
    );
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) => state.totalQuantity,
      builder: (context, totalQuantity) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AppIconButton(
              iconPath: AppAssets.icons.cart,
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.cart,
                arguments: context.read<CartCubit>(),
              ),
            ),
            if (totalQuantity > 0)
              PositionedDirectional(
                top: -AppScale.s(AppSpacing.xxs),
                end: -AppScale.s(AppSpacing.xxs),
                child: _CountBadge(count: totalQuantity),
              ),
          ],
        );
      },
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        constraints: BoxConstraints(
          minWidth: AppScale.s(AppSizes.badge),
          minHeight: AppScale.s(AppSizes.badge),
        ),
        padding: AppScale.symmetric(horizontal: AppSpacing.xxs),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppScale.radius(AppSizes.badge),
        ),
        child: Text(
          '$count',
          style: AppTextStyles.caption.semiBold.onPrimary,
        ),
      ),
    );
  }
}
