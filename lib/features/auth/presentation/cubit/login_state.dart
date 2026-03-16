part of 'login_cubit.dart';

/// State untuk halaman login.
@freezed
class LoginState with _$LoginState {
  /// State awal saat halaman login dibuka.
  const factory LoginState.initial({
    @Default('') String rememberedUsername,
    @Default(false) bool rememberMe,
  }) = LoginInitial;

  /// Sedang proses login ke server.
  const factory LoginState.loading() = LoginLoading;

  /// Login berhasil.
  const factory LoginState.success() = LoginSuccess;

  /// Login gagal dengan pesan error.
  const factory LoginState.error(String message) = LoginError;
}
