import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_token.dart';
import '../entities/login_params.dart';

/// Interface repository untuk autentikasi.
abstract class AuthRepository {
  /// Login dengan username dan password.
  Future<Either<Failure, AuthToken>> login(LoginParams params);

  /// Simpan token ke local storage.
  Future<Either<Failure, void>> saveToken(AuthToken token);

  /// Ambil token yang tersimpan.
  Future<Either<Failure, AuthToken>> getSavedToken();

  /// Hapus token (logout).
  Future<Either<Failure, void>> clearToken();

  /// Simpan username untuk remember me.
  Future<Either<Failure, void>> saveRememberedUsername(String username);

  /// Ambil username yang disimpan dari remember me.
  Future<Either<Failure, String?>> getRememberedUsername();

  /// Hapus username yang disimpan.
  Future<Either<Failure, void>> clearRememberedUsername();
}
