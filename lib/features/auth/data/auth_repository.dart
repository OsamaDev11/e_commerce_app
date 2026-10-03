import '../../../core/networking/app_failure.dart';
import '../../../core/networking/app_result.dart';

class AuthRepository {
  Future<AppResult<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Mock network delay
      await Future.delayed(
        const Duration(milliseconds: 800),
      );

      final isValidCredentials =
          email == 'user@example.com' &&
              password == '123456';

      if (!isValidCredentials) {
        return const AppFailureResult(
          AppFailure(
            type: AppFailureType.invalidCredentials,
          ),
        );
      }

      return const AppSuccess<void>(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.unknown,
        ),
      );
    }
  }
}