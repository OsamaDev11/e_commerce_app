import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:e_commerce_app/core/di/dependency_injection.dart';
import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/features/auth/data/repos/auth_repository.dart';
import 'package:e_commerce_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupDependencies();
  final hasSession = await getIt<AuthRepository>().hasSession();

  runApp(
    MyApp(
      appRouter: AppRouter(),
      initialRoute: hasSession ? Routes.home : Routes.login,
    ),
  );
}
