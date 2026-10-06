import '../../../core/constants/app_assets.dart';
import 'product_model.dart';

abstract final class DemoProducts {
  static final List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: 'Headphones',
      price: 79.99,
      imageAsset: AppAssets.images.img1,
    ),
    ProductModel(
      id: 2,
      name: 'Smart Watch',
      price: 129.00,
      imageAsset: AppAssets.images.img2,
    ),
    ProductModel(
      id: 3,
      name: 'Backpack',
      price: 64.25,
      imageAsset: AppAssets.images.img3,
    ),
    ProductModel(
      id: 4,
      name: 'Sneakers',
      price: 95.50,
      imageAsset: AppAssets.images.img4,

    ),
  ];
}