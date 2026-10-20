import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/core/networking/safe_api_call.dart';
import 'package:e_commerce_app/core/storage/token_storage.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/auth_api_service.dart';
import 'package:e_commerce_app/features/auth/data/models/login_request.dart';
import 'package:e_commerce_app/features/auth/data/models/login_response.dart';

class AuthRepository {
  const AuthRepository(this._apiService, this._tokenStorage);

  final AuthApiService _apiService;
  final TokenStorage _tokenStorage;

  Future<AppResult<LoginResponse>> login({
    required String username,
    required String password,
  }) {
    return safeApiCall(() async {
      final response = await _apiService.login(
        LoginRequest(username: username, password: password),
      );
      await _tokenStorage.save(response.tokens);
      return response;
    });
  }

  Future<bool> hasSession() => _tokenStorage.hasTokens();
}
