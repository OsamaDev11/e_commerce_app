import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/logic/login_cubit.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/cart/ui/cart_screen.dart';
import '../../features/products/ui/home_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(
              AuthRepository(),
            ),
            child: const LoginScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}