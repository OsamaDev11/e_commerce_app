import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/networking/app_result.dart';
import 'package:e_commerce_app/features/auth/data/auth_repository.dart';
import 'package:e_commerce_app/features/auth/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginInitial());

  final AuthRepository _authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    switch (result) {
      case AppSuccess<void>():
        emit(const LoginSuccess());
      case AppFailureResult<void>(:final failure):
        emit(LoginFailure(failure));
    }
  }
}
