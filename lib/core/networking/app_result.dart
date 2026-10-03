import 'app_failure.dart';

sealed class AppResult<T> {
  const AppResult();
}

final class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.data);

  final T data;
}

final class AppFailureResult<T> extends AppResult<T> {
  const AppFailureResult(this.failure);

  final AppFailure failure;
}