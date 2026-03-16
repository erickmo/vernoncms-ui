import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/content.dart';
import '../repositories/content_repository.dart';

/// Use case untuk membuat konten baru.
class CreateContentUseCase {
  final ContentRepository _repository;

  const CreateContentUseCase(this._repository);

  /// Returns [Right(Content)] jika berhasil.
  Future<Either<Failure, Content>> call(Content content) {
    return _repository.createContent(content);
  }
}
