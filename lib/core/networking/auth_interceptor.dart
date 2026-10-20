import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:e_commerce_app/core/networking/api_constants.dart';
import 'package:e_commerce_app/core/storage/auth_tokens.dart';
import 'package:e_commerce_app/core/storage/token_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
    required Dio plainDio,
    required VoidCallback onSessionExpired,
  })  : _tokenStorage = tokenStorage,
        _plainDio = plainDio,
        _onSessionExpired = onSessionExpired;

  static const String _authorizationHeader = 'Authorization';

  final TokenStorage _tokenStorage;
  final Dio _plainDio;
  final VoidCallback _onSessionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_requiresAuth(options)) {
      final tokens = await _tokenStorage.read();
      if (tokens != null) {
        options.headers[_authorizationHeader] = _bearer(tokens.accessToken);
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    if (!isUnauthorized || !_requiresAuth(err.requestOptions)) {
      handler.next(err);
      return;
    }

    final tokens = await _tokenStorage.read();
    if (tokens == null) {
      handler.next(err);
      return;
    }

    final AuthTokens freshTokens;
    try {
      freshTokens = _wasAlreadyRefreshed(err.requestOptions, tokens)
          ? tokens
          : await _refreshTokens(tokens.refreshToken);
    } catch (refreshError) {
      if (_isRefreshRejected(refreshError)) await _expireSession();
      handler.next(err);
      return;
    }

    try {
      handler.resolve(await _retry(err.requestOptions, freshTokens));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<AuthTokens> _refreshTokens(String refreshToken) async {
    final response = await _plainDio.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {
        'refreshToken': refreshToken,
        'expiresInMins': ApiConstants.tokenExpiryMinutes,
      },
    );

    final tokens = AuthTokens.fromJson(response.data!);
    await _tokenStorage.save(tokens);
    return tokens;
  }

  Future<Response<dynamic>> _retry(RequestOptions options, AuthTokens tokens) {
    options.headers[_authorizationHeader] = _bearer(tokens.accessToken);
    return _plainDio.fetch<dynamic>(options);
  }

  Future<void> _expireSession() async {
    await _tokenStorage.clear();
    _onSessionExpired();
  }

  bool _requiresAuth(RequestOptions options) {
    return options.extra[ApiConstants.requiresAuthKey] != false;
  }

  bool _wasAlreadyRefreshed(RequestOptions options, AuthTokens tokens) {
    return options.headers[_authorizationHeader] != _bearer(tokens.accessToken);
  }

  bool _isRefreshRejected(Object error) {
    if (error is! DioException) return true;

    final statusCode = error.response?.statusCode;
    return statusCode != null && statusCode < 500;
  }

  String _bearer(String accessToken) => 'Bearer $accessToken';
}
