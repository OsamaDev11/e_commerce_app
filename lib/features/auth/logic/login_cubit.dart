import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/features/auth/data/repos/auth_repository.dart';
import 'package:e_commerce_app/features/auth/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void usernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> submit() async {
    if (state.isLoading) return;

    if (!state.isValid) {
      emit(state.copyWith(showErrors: true));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    final result = await _authRepository.login(
      username: state.username.trim(),
      password: state.password,
    );

    if (isClosed) return;

    switch (result) {
      case AppSuccess():
        emit(state.copyWith(status: LoginStatus.success));
      case AppFailureResult(:final failure):
        emit(state.copyWith(status: LoginStatus.failure, failure: failure));
    }
  }
}
