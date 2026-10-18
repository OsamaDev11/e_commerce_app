import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/features/products/data/models/products_response.dart';

part 'products_api_service.g.dart';

@RestApi()
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio, {String? baseUrl}) = _ProductsApiService;

  @GET(ApiEndpoints.products)
  Future<ProductsResponse> getProducts(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );
}
