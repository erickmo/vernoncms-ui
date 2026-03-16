import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cms_user.dart';

/// Interface repository untuk user management.
abstract class UserRepository {
  /// Ambil daftar user.
  Future<Either<Failure, List<CmsUser>>> getUsers({
    String? search,
    String? role,
    bool? isActive,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail user berdasarkan [id].
  Future<Either<Failure, CmsUser>> getUserById(String id);

  /// Buat user baru.
  Future<Either<Failure, CmsUser>> createUser(
    CmsUser user, {
    required String password,
  });

  /// Perbarui user yang sudah ada.
  Future<Either<Failure, CmsUser>> updateUser(CmsUser user);

  /// Hapus user berdasarkan [id] (soft delete).
  Future<Either<Failure, void>> deleteUser(String id);

  /// Toggle status aktif user.
  Future<Either<Failure, CmsUser>> toggleUserActive(String id);

  /// Reset password user oleh admin.
  Future<Either<Failure, void>> resetUserPassword(
    String id, {
    required String newPassword,
  });
}
