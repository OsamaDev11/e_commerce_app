import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:e_commerce_app/core/routing/app_router.dart';
import 'package:e_commerce_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(appRouter: AppRouter()));
}
