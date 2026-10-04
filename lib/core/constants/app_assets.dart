class AppAssets {
  AppAssets._();

  static const AppImages images = AppImages();
  static const AppIcons icons = AppIcons();
}

class AppImages {
  const AppImages();

  static const String _imagesPath = 'assets/images';

  final String img1 = '$_imagesPath/img1.png';
  final String img2 = '$_imagesPath/img2.png';
  final String img3 = '$_imagesPath/img3.png';
  final String img4 = '$_imagesPath/img4.png';



}

class AppIcons {
  const AppIcons();

  static const String _iconsPath = 'assets/icons';

  final String shoppingBag = '$_iconsPath/shopping_bag.png';
  final String email = '$_iconsPath/email_icon.svg';
  final String lock = '$_iconsPath/lock_icon.svg';
  final String cart = '$_iconsPath/cart_icon.svg';

  final String back = '$_iconsPath/back_icon.svg';
  final String remove = '$_iconsPath/remove_icon.svg';
  final String increase = '$_iconsPath/increase_icon.svg';
  final String decrease = '$_iconsPath/decrease_icon.svg';


}

