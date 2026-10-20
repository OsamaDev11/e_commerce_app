import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/networking/app_failure_message.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/core/theming/app_dimens.dart';
import 'package:e_commerce_app/core/theming/app_text_styles.dart';
import 'package:e_commerce_app/core/utils/snack_bar_extension.dart';
import 'package:e_commerce_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_app/core/widgets/app_section_header.dart';
import 'package:e_commerce_app/core/widgets/app_status_views.dart';
import 'package:e_commerce_app/core/widgets/app_top_bar.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';
import 'package:e_commerce_app/features/products/logic/products_cubit.dart';
import 'package:e_commerce_app/features/products/logic/products_state.dart';
import 'package:e_commerce_app/features/products/ui/home_sections.dart';
import 'package:e_commerce_app/features/products/ui/widgets/category_item.dart';
import 'package:e_commerce_app/features/products/ui/widgets/product_card.dart';

void _addToCart(BuildContext context, ProductModel product) {
  context.read<CartCubit>().addProduct(product);
  context.showSnackBarMessage(context.l10n.addedToCart(product.title));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppTopBar(
              title: context.l10n.appName,
              actions: const [_CartButton()],
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  final l10n = context.l10n;

                  final Widget content = switch (state) {
                    ProductsLoading() => const _FillRemaining(
                        child: AppLoadingView(),
                      ),
                    ProductsFailure(:final failure) => _FillRemaining(
                        child: AppStatusView(
                          icon: Icons.cloud_off_rounded,
                          title: failure.userMessage(l10n),
                          actionLabel: l10n.retry,
                          onAction: () =>
                              context.read<ProductsCubit>().loadProducts(),
                        ),
                      ),
                    ProductsSuccess(:final products) when products.isEmpty =>
                      _FillRemaining(
                        child: AppStatusView(
                          icon: Icons.inventory_2_outlined,
                          title: l10n.noProductsFound,
                        ),
                      ),
                    ProductsSuccess(:final products) => _HomeContent(
                        sections: HomeSections.from(products),
                      ),
                  };

                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<ProductsCubit>().loadProducts(),
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [content],
                    ),
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

class _FillRemaining extends StatelessWidget {
  const _FillRemaining({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(hasScrollBody: false, child: child);
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.sections});

  final HomeSections sections;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SliverPadding(
      padding: AppScale.symmetric(vertical: AppSpacing.md),
      sliver: SliverMainAxisGroup(
        slivers: [
          if (sections.categories.isNotEmpty)
            _Section(
              title: l10n.category,
              child: _CategoriesRow(categories: sections.categories),
            ),
          if (sections.flashSale.isNotEmpty)
            _Section(
              title: l10n.flashSale,
              child: _ProductsRow(products: sections.flashSale),
            ),
          if (sections.megaSale.isNotEmpty)
            _Section(
              title: l10n.megaSale,
              child: _ProductsRow(products: sections.megaSale),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppScale.only(bottom: AppSpacing.sm),
              child: AppSectionHeader(title: l10n.recommendedProduct),
            ),
          ),
          _ProductsGrid(products: sections.recommended),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppScale.only(bottom: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSectionHeader(title: title),
            AppScale.gh(AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppScale.symmetric(horizontal: AppSpacing.page),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < categories.length; index++) ...[
            if (index > 0) AppScale.gw(AppSpacing.sm),
            CategoryItem(slug: categories[index]),
          ],
        ],
      ),
    );
  }
}

class _ProductsRow extends StatelessWidget {
  const _ProductsRow({required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppScale.symmetric(horizontal: AppSpacing.page),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var index = 0; index < products.length; index++) ...[
              if (index > 0) AppScale.gw(AppSpacing.md),
              SizedBox(
                width: AppScale.s(AppSizes.productCard),
                child: ProductCard(
                  product: products[index],
                  onTap: () => _addToCart(context, products[index]),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({required this.products});

  static const int _columns = 2;

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final rowCount = (products.length / _columns).ceil();

    return SliverPadding(
      padding: AppScale.symmetric(horizontal: AppSpacing.page),
      sliver: SliverList.separated(
        itemCount: rowCount,
        separatorBuilder: (context, index) => AppScale.gh(AppSpacing.sm),
        itemBuilder: (context, row) {
          final rowProducts = products
              .skip(row * _columns)
              .take(_columns)
              .toList();

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var column = 0; column < _columns; column++) ...[
                  if (column > 0) AppScale.gw(AppSpacing.sm),
                  Expanded(
                    child: column < rowProducts.length
                        ? ProductCard(
                            product: rowProducts[column],
                            showRating: true,
                            onTap: () =>
                                _addToCart(context, rowProducts[column]),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
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
              icon: Icons.shopping_cart_outlined,
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.cart,
                arguments: context.read<CartCubit>(),
              ),
            ),
            if (totalQuantity > 0)
              PositionedDirectional(
                top: AppScale.s(AppSpacing.xxs),
                end: AppScale.s(AppSpacing.xxs),
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
          color: AppColors.error,
          borderRadius: AppScale.radius(AppSizes.badge),
        ),
        child: Text(
          '$count',
          style: AppTextStyles.caption.bold.onPrimary.withHeight(1.2),
        ),
      ),
    );
  }
}
