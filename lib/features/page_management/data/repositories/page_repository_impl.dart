import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/page_entity.dart';
import '../../domain/repositories/page_repository.dart';
import '../datasources/page_remote_datasource.dart';
import '../models/page_model.dart';

/// Implementasi [PageRepository].
class PageRepositoryImpl implements PageRepository {
  final PageRemoteDataSource _remoteDataSource;

  const PageRepositoryImpl({
    required PageRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<PageEntity>>> getPages({
    String? search,
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remoteDataSource.getPages(
        search: search,
        status: status,
        page: page,
        perPage: perPage,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PageEntity>> getPageById(String id) async {
    try {
      final response = await _remoteDataSource.getPageById(id);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PageEntity>> createPage(
    PageEntity pageEntity,
  ) async {
    try {
      final model = PageModel.fromEntity(pageEntity);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('created_at');
      data.remove('updated_at');

      final response = await _remoteDataSource.createPage(data);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PageEntity>> updatePage(
    PageEntity pageEntity,
  ) async {
    try {
      final model = PageModel.fromEntity(pageEntity);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('created_at');
      data.remove('updated_at');

      final response = await _remoteDataSource.updatePage(
        pageEntity.id,
        data,
      );
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deletePage(String id) async {
    try {
      await _remoteDataSource.deletePage(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
