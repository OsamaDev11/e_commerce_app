// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInToContinue => 'Sign in to continue shopping.';

  @override
  String get username => 'Username';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => '••••••••';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get signIn => 'Sign in';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get discoverProducts => 'Discover products';

  @override
  String get featured => 'Featured';

  @override
  String productsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
      zero: 'No products',
    );
    return '$_temp0';
  }

  @override
  String get noProductsFound => 'No products found';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get myCart => 'My Cart';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get itemsTotal => 'Items total';

  @override
  String get total => 'Total';

  @override
  String get continueShopping => 'Continue shopping';

  @override
  String get cartIsEmpty => 'Your cart is empty';

  @override
  String get addProductsToCart => 'Add some products to your cart.';

  @override
  String get retry => 'Try again';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get errorNoInternet =>
      'No internet connection. Check your network and try again.';

  @override
  String get errorTimeout => 'The connection timed out. Please try again.';

  @override
  String get errorBadRequest =>
      'The request could not be completed. Please check your input.';

  @override
  String get errorUnauthorized => 'Please sign in to continue.';

  @override
  String get errorForbidden => 'You don\'t have permission to do this.';

  @override
  String get errorNotFound => 'We couldn\'t find what you\'re looking for.';

  @override
  String get errorServer =>
      'The server is having trouble. Please try again later.';

  @override
  String get pageNotFound => 'Page not found';
}
