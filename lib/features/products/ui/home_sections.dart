import 'package:e_commerce_app/features/products/data/models/product_model.dart';

final class HomeSections {
  const HomeSections._({
    required this.categories,
    required this.flashSale,
    required this.megaSale,
    required this.recommended,
  });

  factory HomeSections.from(List<ProductModel> products) {
    final byDiscount = [...products]
      ..sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
    final byRating = [...products]
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return HomeSections._(
      categories: products.map((product) => product.category).toSet().toList(),
      flashSale: byDiscount.take(_sectionSize).toList(),
      megaSale: byDiscount.skip(_sectionSize).take(_sectionSize).toList(),
      recommended: byRating,
    );
  }

  static const int _sectionSize = 10;

  final List<String> categories;
  final List<ProductModel> flashSale;
  final List<ProductModel> megaSale;
  final List<ProductModel> recommended;
}
