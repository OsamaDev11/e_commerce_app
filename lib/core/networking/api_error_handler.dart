import 'dart:io';

import 'package:dio/dio.dart';

import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/core/networking/app_failure.dart';

abstract final class ApiErrorHandler {
  static AppFailure handle(Object error) {
    if (error is DioException) return _fromDioException(error);
    if (error is FormatException || error is TypeError) {
      return const AppFailure(AppFailureType.parsing);
    }
    return const AppFailure(AppFailureType.unknown);
  }

  static AppFailure _fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const AppFailure(AppFailureType.timeout),
      DioExceptionType.connectionError =>
        const AppFailure(AppFailureType.noInternet),
      DioExceptionType.cancel => const AppFailure(AppFailureType.cancelled),
      DioExceptionType.badResponse => _fromResponse(exception.response),
      _ => exception.error is SocketException
          ? const AppFailure(AppFailureType.noInternet)
          : const AppFailure(AppFailureType.unknown),
    };
  }

  static AppFailure _fromResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;

    final type = switch (statusCode) {
      401 => AppFailureType.unauthorized,
      403 => AppFailureType.forbidden,
      404 => AppFailureType.notFound,
      final int code when code >= 500 => AppFailureType.server,
      final int code when code >= 400 => AppFailureType.badRequest,
      _ => AppFailureType.unknown,
    };

    return AppFailure(
      type,
      statusCode: statusCode,
      serverMessage: _readServerMessage(response?.data),
    );
  }

  static String? _readServerMessage(Object? data) {
    if (data is! Map) return null;

    for (final key in ApiConstants.errorMessageKeys) {
      final message = data[key];
      if (message is String && message.isNotEmpty) return message;
    }

    return null;
  }
}
