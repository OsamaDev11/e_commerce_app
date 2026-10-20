import 'package:e_commerce_app/core/networking/app_failure.dart';

enum LoginStatus { initial, loading, success, failure }

final class LoginState {
  const LoginState({
    this.username = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.showErrors = false,
    this.failure,
  });

  final String username;
  final String password;
  final LoginStatus status;
  final bool showErrors;
  final AppFailure? failure;

  bool get isUsernameValid => username.trim().isNotEmpty;
  bool get isPasswordValid => password.isNotEmpty;
  bool get isValid => isUsernameValid && isPasswordValid;
  bool get isLoading => status == LoginStatus.loading;

  bool get showUsernameError => showErrors && !isUsernameValid;
  bool get showPasswordError => showErrors && !isPasswordValid;

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    bool? showErrors,
    AppFailure? failure,
  }) {
    final nextStatus = status ?? this.status;

    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: nextStatus,
      showErrors: showErrors ?? this.showErrors,
      failure: nextStatus == LoginStatus.failure
          ? failure ?? this.failure
          : null,
    );
  }
}
