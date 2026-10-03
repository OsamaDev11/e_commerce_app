import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';
import 'my_app.dart';

void main() {
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}