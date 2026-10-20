import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/app_navigator.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/core/theming/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  final AppRouter appRouter;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        AppScale.init(context);

        return MediaQuery.withClampedTextScaling(
          maxScaleFactor: AppScale.maxTextScaleFactor,
          child: Theme(
            data: AppTheme.light,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      initialRoute: initialRoute,
      onGenerateInitialRoutes: (routeName) => [
        appRouter.generateRoute(RouteSettings(name: routeName)),
      ],
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
