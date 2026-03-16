import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/content_category.dart';
import '../repositories/content_category_repository.dart';

/// Use case untuk mengambil daftar kategori konten.
class GetContentCategoriesUseCase {
  final ContentCategoryRepository _repository;

  const GetContentCategoriesUseCase(this._repository);

  /// Returns [Right(List<ContentCategory>)] jika berhasil.
  Future<Either<Failure, List<ContentCategory>>> call({
    String? search,
    String? parentId,
    int page = 1,
    int perPage = 10,
  }) {
    return _repository.getCategories(
      search: search,
      parentId: parentId,
      page: page,
      perPage: perPage,
    );
  }
}
