import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/page_entity.dart';

/// Interface repository untuk halaman CMS.
abstract class PageRepository {
  /// Ambil daftar halaman.
  Future<Either<Failure, List<PageEntity>>> getPages({
    String? search,
    String? status,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail halaman berdasarkan [id].
  Future<Either<Failure, PageEntity>> getPageById(String id);

  /// Buat halaman baru.
  Future<Either<Failure, PageEntity>> createPage(PageEntity pageEntity);

  /// Perbarui halaman yang sudah ada.
  Future<Either<Failure, PageEntity>> updatePage(PageEntity pageEntity);

  /// Hapus halaman berdasarkan [id].
  Future<Either<Failure, void>> deletePage(String id);
}
