import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cms_user.dart';
import '../repositories/user_repository.dart';

/// Use case untuk toggle status aktif user.
class ToggleUserActiveUseCase {
  final UserRepository _repository;

  const ToggleUserActiveUseCase(this._repository);

  /// Returns [Right(CmsUser)] jika berhasil.
  Future<Either<Failure, CmsUser>> call(String id) {
    return _repository.toggleUserActive(id);
  }
}
