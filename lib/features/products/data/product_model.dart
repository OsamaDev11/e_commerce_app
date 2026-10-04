class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageAsset,
  });

  final int id;
  final String name;
  final double price;
  final String imageAsset;
}