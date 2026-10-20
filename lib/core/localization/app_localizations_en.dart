// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Lafyuu';

  @override
  String get welcomeTitle => 'Welcome to Lafyuu';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get usernameHint => 'Your Username';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get passwordHint => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get signIn => 'Sign In';

  @override
  String get category => 'Category';

  @override
  String get flashSale => 'Flash Sale';

  @override
  String get megaSale => 'Mega Sale';

  @override
  String get recommendedProduct => 'Recommended Product';

  @override
  String discountOff(int percent) {
    return '$percent% Off';
  }

  @override
  String addedToCart(String title) {
    return '$title added to cart';
  }

  @override
  String get noProductsFound => 'No products found';

  @override
  String get yourCart => 'Your Cart';

  @override
  String itemsSummary(int count) {
    return 'Items ($count)';
  }

  @override
  String get discount => 'Discount';

  @override
  String get totalPrice => 'Total Price';

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
