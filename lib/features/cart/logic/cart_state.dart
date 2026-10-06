import '../data/cart_item_model.dart';

final class CartState {
  const CartState({
    this.items = const [],
  });

  final List<CartItemModel> items;

  int get totalQuantity {
    return items.fold(
      0, (total, item) => total + item.quantity,
    );
  }

  double get totalPrice {
    return items.fold(
      0, (total, item) => total + (item.product.price * item.quantity),
    );
  }

  bool get isEmpty => items.isEmpty;

  CartState copyWith({
    List<CartItemModel>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}