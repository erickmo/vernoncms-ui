import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/login_params.dart';
import '../../domain/usecases/get_remembered_username_usecase.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

/// Cubit untuk mengelola state halaman login.
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GetRememberedUsernameUseCase _getRememberedUsernameUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required GetRememberedUsernameUseCase getRememberedUsernameUseCase,
  })  : _loginUseCase = loginUseCase,
        _getRememberedUsernameUseCase = getRememberedUsernameUseCase,
        super(const LoginState.initial());

  /// Memuat username yang tersimpan dari remember me.
  Future<void> loadRememberedUsername() async {
    final result = await _getRememberedUsernameUseCase();

    result.fold(
      (_) => null,
      (username) {
        if (username != null && username.isNotEmpty) {
          emit(LoginState.initial(
            rememberedUsername: username,
            rememberMe: true,
          ));
        }
      },
    );
  }

  /// Melakukan login dengan [username] dan [password].
  Future<void> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    emit(const LoginState.loading());

    final params = LoginParams(
      username: username,
      password: password,
      rememberMe: rememberMe,
    );

    final result = await _loginUseCase(params);

    result.fold(
      (failure) => emit(LoginState.error(failure.message)),
      (_) => emit(const LoginState.success()),
    );
  }
}
