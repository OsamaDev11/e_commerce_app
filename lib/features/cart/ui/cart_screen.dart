import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/theming/app_colors.dart';
import 'package:e_commerce_app/features/cart/data/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state.isEmpty) {
                          return _buildEmptyCart(context);
                        }
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: AppScale.symmetric(
                                  horizontal: 24,
                                  vertical: 24,
                                ),
                                itemCount: state.items.length,
                                separatorBuilder: (context, length) {
                                  return AppScale.gh(14);
                                },
                                itemBuilder: (context, index) {
                                  return _CartItemCard(
                                    item: state.items[index],
                                  );
                                },
                              ),
                            ),
                            _buildCartSummary(context, state),
                          ],
                        );
                      },
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
      padding: AppScale.symmetric(horizontal: 20, vertical: 22),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppScale.r(12)),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: AppScale.s(40),
              height: AppScale.s(40),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(AppScale.r(12)),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.icons.back,
                width: AppScale.s(40),
                height: AppScale.s(40),
              ),
            ),
          ),

          AppScale.gw(14),

          Expanded(
            child: Text(
              context.l10n.myCart,
              style: TextStyle(
                fontSize: AppScale.sp(22),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          BlocSelector<CartCubit, CartState, int>(
            selector: (state) => state.totalQuantity,
            builder: (context, totalQuantity) {
              return Text(
                '$totalQuantity ${context.l10n.items}',
                style: TextStyle(
                  fontSize: AppScale.sp(12),
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartState state) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: AppScale.symmetric(horizontal: 24, vertical: 22),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                context.l10n.itemsTotal,
                style: TextStyle(
                  fontSize: AppScale.sp(13),
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(),

              Text(
                '\$${state.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: AppScale.sp(14),
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          AppScale.gh(14),

          Container(height: 1, color: AppColors.border),

          AppScale.gh(14),

          Row(
            children: [
              Text(
                context.l10n.total,
                style: TextStyle(
                  fontSize: AppScale.sp(17),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const Spacer(),

              Text(
                '\$${state.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: AppScale.sp(18),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          AppScale.gh(20),

          SizedBox(
            width: double.infinity,
            height: AppScale.s(50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppScale.r(12)),
                ),
              ),
              child: Text(
                context.l10n.continueShopping,
                style: TextStyle(
                  fontSize: AppScale.sp(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppScale.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: AppScale.s(58),
              color: AppColors.textSecondary,

              // TODO:
              // Replace with your empty-cart asset if desired.
            ),

            AppScale.gh(18),

            Text(
              context.l10n.cartIsEmpty,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppScale.sp(18),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            AppScale.gh(8),

            Text(
              context.l10n.addProductsToCart,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppScale.sp(13),
                color: AppColors.textSecondary,
              ),
            ),

            AppScale.gh(24),

            SizedBox(
              width: AppScale.s(180),
              height: AppScale.s(46),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppScale.r(12)),
                  ),
                ),
                child: Text(context.l10n.continueShopping),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Container(
      padding: AppScale.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppScale.r(16)),
      ),
      child: Row(
        children: [
          Image.asset(
            product.imageAsset,
            width: AppScale.s(60),
            height: AppScale.s(60),
            fit: BoxFit.contain,
          ),

          AppScale.gw(14),

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
                        style: TextStyle(
                          fontSize: AppScale.sp(13),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    AppScale.gw(8),

                    InkWell(
                      borderRadius: BorderRadius.circular(AppScale.r(8)),
                      onTap: () {
                        context.read<CartCubit>().removeProduct(product.id);
                      },
                      child: SvgPicture.asset(
                        AppAssets.icons.remove,
                        width: AppScale.s(32),
                        height: AppScale.s(32),
                      ),
                    ),
                  ],
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

                AppScale.gh(12),

                Row(
                  children: [
                    _QuantityButton(
                      iconPath: AppAssets.icons.decrease,
                      onPressed: () {
                        context.read<CartCubit>().decreaseQuantity(product.id);
                      },
                    ),

                    Container(
                      width: AppScale.s(38),
                      alignment: Alignment.center,
                      child: Text(
                        item.quantity.toString(),
                        style: TextStyle(
                          fontSize: AppScale.sp(13),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    _QuantityButton(
                      iconPath: AppAssets.icons.increase,
                      onPressed: () {
                        context.read<CartCubit>().increaseQuantity(product.id);
                      },
                    ),

                    const Spacer(),

                    Text(
                      '\$${(product.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: AppScale.sp(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
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

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.iconPath, required this.onPressed});

  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppScale.r(8)),
      onTap: onPressed,
      child: Container(
        width: AppScale.s(30),
        height: AppScale.s(30),
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(AppScale.r(8)),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: AppScale.s(12),
          height: AppScale.s(12),
          child: SvgPicture.asset(iconPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
