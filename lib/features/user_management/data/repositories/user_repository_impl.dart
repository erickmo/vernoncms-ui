import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/cms_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/cms_user_model.dart';

/// Implementasi [UserRepository].
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  const UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<CmsUser>>> getUsers({
    String? search,
    String? role,
    bool? isActive,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remoteDataSource.getUsers(
        search: search,
        role: role,
        isActive: isActive,
        page: page,
        perPage: perPage,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CmsUser>> getUserById(String id) async {
    try {
      final response = await _remoteDataSource.getUserById(id);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CmsUser>> createUser(
    CmsUser user, {
    required String password,
  }) async {
    try {
      final model = CmsUserModel.fromEntity(user);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('last_login_at');
      data.remove('created_at');
      data.remove('updated_at');
      // Tambahkan password untuk create.
      data['password'] = password;

      final response = await _remoteDataSource.createUser(data);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CmsUser>> updateUser(CmsUser user) async {
    try {
      final model = CmsUserModel.fromEntity(user);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('last_login_at');
      data.remove('created_at');
      data.remove('updated_at');

      final response = await _remoteDataSource.updateUser(user.id, data);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _remoteDataSource.deleteUser(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CmsUser>> toggleUserActive(String id) async {
    try {
      final response = await _remoteDataSource.toggleUserActive(id);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> resetUserPassword(
    String id, {
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetUserPassword(id, {
        'new_password': newPassword,
      });
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
