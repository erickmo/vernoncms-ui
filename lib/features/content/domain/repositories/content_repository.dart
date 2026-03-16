import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/content.dart';

/// Interface repository untuk konten.
abstract class ContentRepository {
  /// Ambil daftar konten.
  Future<Either<Failure, List<Content>>> getContents({
    String? search,
    String? status,
    String? categoryId,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail konten berdasarkan [id].
  Future<Either<Failure, Content>> getContentById(String id);

  /// Buat konten baru.
  Future<Either<Failure, Content>> createContent(Content content);

  /// Perbarui konten yang sudah ada.
  Future<Either<Failure, Content>> updateContent(Content content);

  /// Hapus konten berdasarkan [id].
  Future<Either<Failure, void>> deleteContent(String id);
}
