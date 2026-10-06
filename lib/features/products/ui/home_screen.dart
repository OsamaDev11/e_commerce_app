import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/features/products/data/demo_products.dart';
import 'package:e_commerce_app/features/products/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routing/routes.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../cart/logic/cart_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppScale.symmetric(horizontal: 16, vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppScale.r(28)),
            child: Container(
              width: double.infinity,
              color: AppColors.inputBackground,
              child: Column(
                children: [
                  _buildHeader(context),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: AppScale.symmetric(horizontal: 26, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.featured,
                            style: TextStyle(
                              fontSize: AppScale.sp(17),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          AppScale.gh(4),

                          Text(
                            '${DemoProducts.products.length} ${context.l10n.products}',
                            style: TextStyle(
                              fontSize: AppScale.sp(12),
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          AppScale.gh(20),

                          _buildProductsGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: AppScale.symmetric(horizontal: 26, vertical: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.goodMorning,
                  style: TextStyle(
                    fontSize: AppScale.sp(12),
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),

                AppScale.gh(3),

                Text(
                  context.l10n.discoverProducts,
                  style: TextStyle(
                    fontSize: AppScale.sp(23),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          AppScale.gw(12),

          _buildCartButton(context),
        ],
      ),
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) => state.totalQuantity,
      builder: (context, totalQuantity) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(AppScale.r(14)),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.cart,
                  arguments: context.read<CartCubit>(),
                );
              },
              child: Container(
                width: AppScale.s(44),
                height: AppScale.s(44),
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(AppScale.r(14)),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppAssets.icons.cart,
                  width: AppScale.s(24),
                  height: AppScale.s(21),
                ),
              ),
            ),
            Positioned(
              top: AppScale.s(-6),
              right: AppScale.s(-5),
              child: Container(
                padding: AppScale.hOnly(5),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  totalQuantity.toString(),
                  style: TextStyle(
                    fontSize: AppScale.sp(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      itemCount: DemoProducts.products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppScale.s(14),
        mainAxisSpacing: AppScale.s(16),
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final product = DemoProducts.products[index];

        return _ProductCard(product: product);
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppScale.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppScale.r(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildProductImage()),

          AppScale.gh(12),

          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppScale.sp(13),
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),

          AppScale.gh(5),

          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: AppScale.sp(13),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),

          AppScale.gh(10),

          SizedBox(
            width: double.infinity,
            height: AppScale.s(34),
            child: ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().addProduct(product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppScale.r(9)),
                ),
              ),
              child: Text(
                '+ ${context.l10n.addToCart}',
                style: TextStyle(
                  fontSize: AppScale.sp(10),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Center(
      child: Image.asset(
        product.imageAsset,
        width: AppScale.s(72),
        height: AppScale.s(72),
        fit: BoxFit.contain,
      ),
    );
  }
}
