import 'package:flutter/material.dart';

abstract final class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void resetTo(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }
}
