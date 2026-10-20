import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/features/products/data/repos/products_repository.dart';
import 'package:e_commerce_app/features/products/logic/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository) : super(const ProductsLoading());

  final ProductsRepository _productsRepository;

  Future<void> loadProducts() async {
    if (state is! ProductsSuccess) emit(const ProductsLoading());

    final result = await _productsRepository.getProducts();

    if (isClosed) return;

    switch (result) {
      case AppSuccess(:final data):
        emit(ProductsSuccess(data));
      case AppFailureResult(:final failure):
        emit(ProductsFailure(failure));
    }
  }
}
