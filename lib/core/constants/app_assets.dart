class AppAssets {
  AppAssets._();

  static const AppIcons icons = AppIcons();
}

class AppIcons {
  const AppIcons();

  static const String _iconsPath = 'assets/icons';

  final String shoppingBag = '$_iconsPath/shopping_bag.png';
  final String lock = '$_iconsPath/lock_icon.svg';
  final String cart = '$_iconsPath/cart_icon.svg';
  final String back = '$_iconsPath/back_icon.svg';
  final String remove = '$_iconsPath/remove_icon.svg';
}
