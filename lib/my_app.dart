import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/responsive/app_scale.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/theming/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: Routes.login,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
