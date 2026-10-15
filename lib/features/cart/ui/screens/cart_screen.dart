import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_page_frame.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/cart/ui/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageFrame(
      header: const _CartHeader(),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isEmpty) return const _EmptyCart();

          final cubit = context.read<CartCubit>();

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: AppScale.all(AppSpacing.pagePadding),
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => AppScale.gh(AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    final productId = item.product.id;

                    return CartItemCard(
                      item: item,
                      onIncrease: () => cubit.increaseQuantity(productId),
                      onDecrease: () => cubit.decreaseQuantity(productId),
                      onRemove: () => cubit.removeProduct(productId),
                    );
                  },
                ),
              ),
              _CartSummary(totalPrice: state.totalPrice),
            ],
          );
        },
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        AppIconButton(
          iconPath: AppAssets.icons.back,
          iconSize: AppSizes.iconButton,
          onPressed: () => Navigator.pop(context),
        ),
        AppScale.gw(AppSpacing.sm),
        Expanded(child: Text(l10n.myCart, style: AppTextStyles.h1)),
        BlocSelector<CartCubit, CartState, int>(
          selector: (state) => state.totalQuantity,
          builder: (context, totalQuantity) => Text(
            l10n.itemsCount(totalQuantity),
            style: AppTextStyles.bodySm.medium.secondary,
          ),
        ),
      ],
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ColoredBox(
      color: AppColors.surface,
      child: Padding(
        padding: AppScale.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(l10n.itemsTotal, style: AppTextStyles.body.secondary),
                const Spacer(),
                Text(totalPrice.asPrice, style: AppTextStyles.bodyLg.semiBold),
              ],
            ),
            AppScale.gh(AppSpacing.sm),
            const Divider(),
            AppScale.gh(AppSpacing.sm),
            Row(
              children: [
                Text(l10n.total, style: AppTextStyles.h2),
                const Spacer(),
                Text(totalPrice.asPrice, style: AppTextStyles.h2.primary),
              ],
            ),
            AppScale.gh(AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.continueShopping,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: SingleChildScrollView(
        padding: AppScale.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: AppScale.s(AppSizes.iconXl),
              color: AppColors.textSecondary,
            ),
            AppScale.gh(AppSpacing.md),
            Text(
              l10n.cartIsEmpty,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2,
            ),
            AppScale.gh(AppSpacing.xs),
            Text(
              l10n.addProductsToCart,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.secondary,
            ),
            AppScale.gh(AppSpacing.xl),
            AppPrimaryButton(
              label: l10n.continueShopping,
              expanded: false,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
