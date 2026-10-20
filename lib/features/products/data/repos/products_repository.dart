import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/core/networking/safe_api_call.dart';
import 'package:e_commerce_app/features/products/data/data_sources/products_api_service.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

class ProductsRepository {
  const ProductsRepository(this._apiService);

  final ProductsApiService _apiService;

  Future<AppResult<List<ProductModel>>> getProducts({int skip = 0}) {
    return safeApiCall(() async {
      final response = await _apiService.getProducts(
        ApiConstants.productsPageSize,
        skip,
      );
      return response.products;
    });
  }
}
