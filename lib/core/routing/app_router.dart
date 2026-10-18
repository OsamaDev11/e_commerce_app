import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/di/dependency_injection.dart';
import 'package:e_commerce_app/core/localization/localization_extension.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/features/auth/logic/login_cubit.dart';
import 'package:e_commerce_app/features/auth/ui/screens/login_screen.dart';
import 'package:e_commerce_app/features/cart/logic/cart_cubit.dart';
import 'package:e_commerce_app/features/cart/ui/screens/cart_screen.dart';
import 'package:e_commerce_app/features/products/logic/products_cubit.dart';
import 'package:e_commerce_app/features/products/ui/screens/home_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<ProductsCubit>()..loadProducts(),
              ),
              BlocProvider(create: (_) => CartCubit()),
            ],
            child: const HomeScreen(),
          ),
        );

      case Routes.cart:
        final cartCubit = settings.arguments as CartCubit;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cartCubit,
            child: const CartScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text(context.l10n.pageNotFound)),
          ),
        );
    }
  }
}
