import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/content.dart';
import '../repositories/content_repository.dart';

/// Use case untuk mengambil daftar konten.
class GetContentsUseCase {
  final ContentRepository _repository;

  const GetContentsUseCase(this._repository);

  /// Returns [Right(List<Content>)] jika berhasil.
  Future<Either<Failure, List<Content>>> call({
    String? search,
    String? status,
    String? categoryId,
    int page = 1,
    int perPage = 10,
  }) {
    return _repository.getContents(
      search: search,
      status: status,
      categoryId: categoryId,
      page: page,
      perPage: perPage,
    );
  }
}
