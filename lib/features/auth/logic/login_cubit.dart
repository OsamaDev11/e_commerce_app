import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/networking/app_result.dart';
import '../data/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository)
      : super(const LoginInitial());

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

    if (result is AppSuccess<void>) {
      emit(const LoginSuccess());
      return;
    }

    if (result is AppFailureResult<void>) {
      emit(
        LoginFailure(result.failure),
      );
    }
  }
}