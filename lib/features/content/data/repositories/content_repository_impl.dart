import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/content.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/content_remote_datasource.dart';
import '../models/content_model.dart';

/// Implementasi [ContentRepository].
class ContentRepositoryImpl implements ContentRepository {
  final ContentRemoteDataSource _remoteDataSource;

  const ContentRepositoryImpl({
    required ContentRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<Content>>> getContents({
    String? search,
    String? status,
    String? categoryId,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remoteDataSource.getContents(
        search: search,
        status: status,
        categoryId: categoryId,
        page: page,
        perPage: perPage,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Content>> getContentById(String id) async {
    try {
      final response = await _remoteDataSource.getContentById(id);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Content>> createContent(Content content) async {
    try {
      final model = ContentModel.fromEntity(content);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('author_name');
      data.remove('category_name');
      data.remove('reading_time_minutes');
      data.remove('version');
      data.remove('created_at');
      data.remove('updated_at');

      final response = await _remoteDataSource.createContent(data);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Content>> updateContent(Content content) async {
    try {
      final model = ContentModel.fromEntity(content);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('author_name');
      data.remove('category_name');
      data.remove('reading_time_minutes');
      data.remove('version');
      data.remove('created_at');
      data.remove('updated_at');

      final response = await _remoteDataSource.updateContent(
        content.id,
        data,
      );
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContent(String id) async {
    try {
      await _remoteDataSource.deleteContent(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
