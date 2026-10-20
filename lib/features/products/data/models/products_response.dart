import 'package:json_annotation/json_annotation.dart';

import 'package:e_commerce_app/features/products/data/models/product_model.dart';

part 'products_response.g.dart';

@JsonSerializable(createToJson: false)
class ProductsResponse {
  const ProductsResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;
}
