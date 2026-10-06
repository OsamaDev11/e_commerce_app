import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/data/product_model.dart';
import '../data/cart_item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(ProductModel product) {
    final existingIndex = state.items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (existingIndex == -1) {
      emit(
        state.copyWith(
          items: [
            ...state.items,
            CartItemModel(
              product: product,
              quantity: 1,
            ),
          ],
        ),
      );

      return;
    }

    increaseQuantity(product.id);
  }

  void increaseQuantity(int productId) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(
          quantity: item.quantity + 1,
        );
      }

      return item;
    }).toList();

    emit(
      state.copyWith(
        items: updatedItems,
      ),
    );
  }

  void decreaseQuantity(int productId) {
    final item = state.items.firstWhere(
          (item) => item.product.id == productId,
    );

    if (item.quantity == 1) {
      removeProduct(productId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(
          quantity: item.quantity - 1,
        );
      }

      return item;
    }).toList();

    emit(
      state.copyWith(
        items: updatedItems,
      ),
    );
  }

  void removeProduct(int productId) {
    final updatedItems = state.items
        .where(
          (item) => item.product.id != productId,
    )
        .toList();

    emit(
      state.copyWith(
        items: updatedItems,
      ),
    );
  }

  void clearCart() {
    emit(const CartState());
  }
}