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
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get emailHint => 'user@example.com';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get discoverProducts => 'Discover products';

  @override
  String get featured => 'Featured';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get myCart => 'My Cart';

  @override
  String get itemsTotal => 'Items total';

  @override
  String get total => 'Total';

  @override
  String get continueShopping => 'Continue shopping';
}
