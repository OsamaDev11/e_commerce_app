class AppAssets {
  AppAssets._();

  static const AppImages images = AppImages();
  static const AppIcons icons = AppIcons();
}

class AppImages {
  const AppImages();

  static const String _imagesPath = 'assets/images';

  final String bgSplash = '$_imagesPath/logo.png';



}

class AppIcons {
  const AppIcons();

  static const String _iconsPath = 'assets/icons';

  final String shoppingBag = '$_iconsPath/shopping_bag.png';
  final String email = '$_iconsPath/email_icon.svg';
  final String lock = '$_iconsPath/lock_icon.svg';


}

