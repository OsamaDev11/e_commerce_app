import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:e_commerce_app/core/networking/dio_factory.dart';
import 'package:e_commerce_app/core/routing/app_navigator.dart';
import 'package:e_commerce_app/core/routing/routes.dart';
import 'package:e_commerce_app/core/storage/token_storage.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/auth_api_service.dart';
import 'package:e_commerce_app/features/auth/data/repos/auth_repository.dart';
import 'package:e_commerce_app/features/auth/logic/login_cubit.dart';
import 'package:e_commerce_app/features/products/data/data_sources/products_api_service.dart';
import 'package:e_commerce_app/features/products/data/repos/products_repository.dart';
import 'package:e_commerce_app/features/products/logic/products_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  _setupCore();
  _setupAuth();
  _setupProducts();
}

void _setupCore() {
  getIt
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()))
    ..registerLazySingleton<Dio>(
      () => DioFactory.create(
        tokenStorage: getIt(),
        onSessionExpired: () => AppNavigator.resetTo(Routes.login),
      ),
    );
}

void _setupAuth() {
  getIt
    ..registerLazySingleton<AuthApiService>(() => AuthApiService(getIt()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepository(getIt(), getIt()),
    )
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}

void _setupProducts() {
  getIt
    ..registerLazySingleton<ProductsApiService>(
      () => ProductsApiService(getIt()),
    )
    ..registerLazySingleton<ProductsRepository>(
      () => ProductsRepository(getIt()),
    )
    ..registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
}
