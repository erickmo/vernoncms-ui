import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/entities/login_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

/// Implementasi [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthToken>> login(LoginParams params) async {
    try {
      final request = LoginRequestModel(
        username: params.username,
        password: params.password,
      );
      final response = await _remoteDataSource.login(request);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      if (e.statusCode == 401) {
        return const Left(
          ServerFailure('Username atau password salah', statusCode: 401),
        );
      }
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> saveToken(AuthToken token) async {
    try {
      await _localDataSource.saveAccessToken(token.accessToken);
      await _localDataSource.saveRefreshToken(token.refreshToken);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> getSavedToken() async {
    try {
      final accessToken = _localDataSource.getAccessToken();
      final refreshToken = _localDataSource.getRefreshToken();

      if (accessToken == null || refreshToken == null) {
        return const Left(CacheFailure('Token tidak ditemukan'));
      }

      return Right(AuthToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: 0,
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearToken() async {
    try {
      await _localDataSource.clearTokens();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveRememberedUsername(String username) async {
    try {
      await _localDataSource.saveRememberedUsername(username);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String?>> getRememberedUsername() async {
    try {
      final username = _localDataSource.getRememberedUsername();
      return Right(username);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearRememberedUsername() async {
    try {
      await _localDataSource.clearRememberedUsername();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
