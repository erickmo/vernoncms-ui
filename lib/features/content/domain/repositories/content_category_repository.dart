import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/content_category.dart';

/// Interface repository untuk kategori konten.
abstract class ContentCategoryRepository {
  /// Ambil daftar kategori konten.
  Future<Either<Failure, List<ContentCategory>>> getCategories({
    String? search,
    String? parentId,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail kategori berdasarkan [id].
  Future<Either<Failure, ContentCategory>> getCategoryById(String id);

  /// Buat kategori baru.
  Future<Either<Failure, ContentCategory>> createCategory(
    ContentCategory category,
  );

  /// Perbarui kategori yang sudah ada.
  Future<Either<Failure, ContentCategory>> updateCategory(
    ContentCategory category,
  );

  /// Hapus kategori berdasarkan [id].
  Future<Either<Failure, void>> deleteCategory(String id);
}
