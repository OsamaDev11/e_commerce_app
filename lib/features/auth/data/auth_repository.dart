import 'package:e_commerce_app/core/networking/app_failure.dart';
import 'package:e_commerce_app/core/networking/app_result.dart';

class AuthRepository {
  Future<AppResult<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final isValidCredentials =
          email == 'osama@email.com' && password == '123456';

      if (!isValidCredentials) {
        return const AppFailureResult(
          AppFailure(type: AppFailureType.invalidCredentials),
        );
      }

      return const AppSuccess<void>(null);
    } catch (_) {
      return const AppFailureResult(
        AppFailure(type: AppFailureType.unknown),
      );
    }
  }
}
