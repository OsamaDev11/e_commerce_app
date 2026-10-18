import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/features/auth/data/repos/auth_repository.dart';
import 'package:e_commerce_app/features/auth/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginInitial());

  final AuthRepository _authRepository;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const LoginLoading());

    final result = await _authRepository.login(
      username: username,
      password: password,
    );

    if (isClosed) return;

    switch (result) {
      case AppSuccess():
        emit(const LoginSuccess());
      case AppFailureResult(:final failure):
        emit(LoginFailure(failure));
    }
  }
}
