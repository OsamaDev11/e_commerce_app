import 'package:e_commerce_app/core/networking/app_failure.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsSuccess extends ProductsState {
  const ProductsSuccess(this.products);

  final List<ProductModel> products;
}

final class ProductsFailure extends ProductsState {
  const ProductsFailure(this.failure);

  final AppFailure failure;
}
