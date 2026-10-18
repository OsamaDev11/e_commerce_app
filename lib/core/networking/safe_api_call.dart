import 'dart:developer';

import 'package:e_commerce_app/core/networking/api_error_handler.dart';
import 'package:e_commerce_app/core/networking/app_result.dart';

Future<AppResult<T>> safeApiCall<T>(Future<T> Function() request) async {
  try {
    return AppSuccess(await request());
  } catch (error, stackTrace) {
    log('$error', name: 'safeApiCall', error: error, stackTrace: stackTrace);
    return AppFailureResult(ApiErrorHandler.handle(error));
  }
}
