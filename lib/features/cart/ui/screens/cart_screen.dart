import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/price_formatter.dart';
import 'package:e_commerce_app/core/widgets/app_status_views.dart';
import 'package:e_commerce_app/core/widgets/app_top_bar.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/cart/ui/widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              title: context.l10n.yourCart,
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.isEmpty) return const _EmptyCart();

                  final cubit = context.read<CartCubit>();

                  return ListView(
                    padding: AppScale.all(AppSpacing.page),
                    children: [
                      for (final item in state.items) ...[
                        CartItemCard(
                          item: item,
                          onIncrease: () =>
                              cubit.increaseQuantity(item.product.id),
                          onDecrease: () =>
                              cubit.decreaseQuantity(item.product.id),
                          onRemove: () => cubit.removeProduct(item.product.id),
                        ),
                        AppScale.gh(AppSpacing.md),
                      ],
                      AppScale.gh(AppSpacing.xs),
                      _CartSummary(state: state),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final discount = state.totalDiscount;

    return Container(
      padding: AppScale.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: AppScale.radius(AppRadius.sm),
        border: Border.all(
          color: AppColors.border,
          width: AppSizes.borderWidth,
        ),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: l10n.itemsSummary(state.totalQuantity),
            value: state.subtotal.asPrice,
          ),
          if (discount > 0) ...[
            AppScale.gh(AppSpacing.sm),
            _SummaryRow(
              label: l10n.discount,
              value: '-${discount.asPrice}',
            ),
          ],
          AppScale.gh(AppSpacing.sm),
          const _DashedDivider(),
          AppScale.gh(AppSpacing.sm),
          _SummaryRow(
            label: l10n.totalPrice,
            value: state.totalPrice.asPrice,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: isTotal
                ? AppTextStyles.body.bold
                : AppTextStyles.body.secondary,
          ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.body.bold.primary
              : AppTextStyles.body,
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashLength = AppScale.s(AppSizes.dashLength);
        final dashCount = (constraints.maxWidth / (dashLength * 2)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (index) => SizedBox(
              width: dashLength,
              height: AppSizes.borderWidth,
              child: const ColoredBox(color: AppColors.border),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppStatusView(
      icon: Icons.shopping_cart_outlined,
      title: l10n.cartIsEmpty,
      message: l10n.addProductsToCart,
      actionLabel: l10n.continueShopping,
      onAction: () => Navigator.pop(context),
    );
  }
}
