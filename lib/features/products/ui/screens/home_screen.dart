import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/networking/app_failure_message.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_page_frame.dart';
import 'package:e_commerce_app/core/widgets/app_status_views.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';
import 'package:e_commerce_app/features/products/logic/products_cubit.dart';
import 'package:e_commerce_app/features/products/logic/products_state.dart';
import 'package:e_commerce_app/features/products/ui/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageFrame(
      header: const _HomeHeader(),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final l10n = context.l10n;
          final cubit = context.read<ProductsCubit>();

          final Widget content = switch (state) {
            ProductsLoading() => const _FillRemaining(
                child: AppLoadingView(),
              ),
            ProductsFailure(:final failure) => _FillRemaining(
                child: AppStatusView(
                  icon: Icons.cloud_off_rounded,
                  title: failure.userMessage(l10n),
                  actionLabel: l10n.retry,
                  onAction: cubit.loadProducts,
                ),
              ),
            ProductsSuccess(:final products) when products.isEmpty =>
              _FillRemaining(
                child: AppStatusView(
                  icon: Icons.inventory_2_outlined,
                  title: l10n.noProductsFound,
                ),
              ),
            ProductsSuccess(:final products) =>
              _ProductsGrid(products: products),
          };

          return RefreshIndicator(
            onRefresh: cubit.loadProducts,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [content],
            ),
          );
        },
      ),
    );
  }
}

class _FillRemaining extends StatelessWidget {
  const _FillRemaining({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(hasScrollBody: false, child: child);
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SliverPadding(
      padding: AppScale.symmetric(
        horizontal: AppSpacing.pagePadding,
        vertical: AppSpacing.lg,
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
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
              ],
            ),
          ),
          SliverGrid.builder(
            itemCount: products.length,
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
