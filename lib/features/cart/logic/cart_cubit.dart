import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce_app/features/cart/logic/cart_state.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(ProductModel product) {
    final exists = state.items.any((item) => item.product.id == product.id);

    if (exists) {
      increaseQuantity(product.id);
      return;
    }

    emit(
      state.copyWith(
        items: [
          ...state.items,
          CartItemModel(product: product, quantity: 1),
        ],
      ),
    );
  }

  void increaseQuantity(int productId) {
    _updateQuantity(productId, (quantity) => quantity + 1);
  }

  void decreaseQuantity(int productId) {
    final matches = state.items.where((item) => item.product.id == productId);
    if (matches.isEmpty) return;

    if (matches.first.quantity == 1) {
      removeProduct(productId);
      return;
    }

    _updateQuantity(productId, (quantity) => quantity - 1);
  }

  void removeProduct(int productId) {
    emit(
      state.copyWith(
        items: state.items
            .where((item) => item.product.id != productId)
            .toList(),
      ),
    );
  }

  void clearCart() {
    emit(const CartState());
  }

  void _updateQuantity(int productId, int Function(int quantity) update) {
    emit(
      state.copyWith(
        items: state.items.map((item) {
          if (item.product.id != productId) return item;
          return item.copyWith(quantity: update(item.quantity));
        }).toList(),
      ),
    );
  }
}
