import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:e_commerce_app/core/storage/auth_tokens.dart';
import 'package:e_commerce_app/core/storage/storage_keys.dart';

class TokenStorage {
  TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  AuthTokens? _tokens;
  bool _isLoaded = false;

  Future<AuthTokens?> read() async {
    if (_isLoaded) return _tokens;

    try {
      final accessToken = await _storage.read(key: StorageKeys.accessToken);
      final refreshToken = await _storage.read(key: StorageKeys.refreshToken);

      _tokens = accessToken == null || refreshToken == null
          ? null
          : AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
    } catch (_) {
      _tokens = null;
    }

    _isLoaded = true;
    return _tokens;
  }

  Future<void> save(AuthTokens tokens) async {
    await _storage.write(
      key: StorageKeys.accessToken,
      value: tokens.accessToken,
    );
    await _storage.write(
      key: StorageKeys.refreshToken,
      value: tokens.refreshToken,
    );

    _tokens = tokens;
    _isLoaded = true;
  }

  Future<void> clear() async {
    _tokens = null;
    _isLoaded = true;

    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }

  Future<bool> hasTokens() async => await read() != null;
}
