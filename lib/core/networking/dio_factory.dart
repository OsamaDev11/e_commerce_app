import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/core/networking/auth_interceptor.dart';
import 'package:e_commerce_app/core/storage/token_storage.dart';

abstract final class DioFactory {
  static Dio create({
    required TokenStorage tokenStorage,
    required VoidCallback onSessionExpired,
  }) {
    final dio = _createDio();
    final plainDio = _createDio();

    dio.interceptors.add(
      AuthInterceptor(
        tokenStorage: tokenStorage,
        plainDio: plainDio,
        onSessionExpired: onSessionExpired,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(_createLogger());
      plainDio.interceptors.add(_createLogger());
    }

    return dio;
  }

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
  }

  static Interceptor _createLogger() {
    return PrettyDioLogger(requestBody: true);
  }
}
