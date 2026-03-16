import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_repository.dart';

/// Use case untuk reset password user oleh admin.
class ResetUserPasswordUseCase {
  final UserRepository _repository;

  const ResetUserPasswordUseCase(this._repository);

  /// Returns [Right(void)] jika berhasil.
  Future<Either<Failure, void>> call(
    String id, {
    required String newPassword,
  }) {
    return _repository.resetUserPassword(id, newPassword: newPassword);
  }
}
