import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case untuk mengambil username yang tersimpan dari remember me.
class GetRememberedUsernameUseCase {
  final AuthRepository _repository;

  const GetRememberedUsernameUseCase(this._repository);

  /// Returns [Right(String?)] username yang tersimpan, null jika tidak ada.
  Future<Either<Failure, String?>> call() {
    return _repository.getRememberedUsername();
  }
}
