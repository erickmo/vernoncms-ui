import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/content_category.dart';
import '../../domain/repositories/content_category_repository.dart';
import '../datasources/content_category_remote_datasource.dart';
import '../models/content_category_model.dart';

/// Implementasi [ContentCategoryRepository].
class ContentCategoryRepositoryImpl implements ContentCategoryRepository {
  final ContentCategoryRemoteDataSource _remoteDataSource;

  const ContentCategoryRepositoryImpl({
    required ContentCategoryRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<ContentCategory>>> getCategories({
    String? search,
    String? parentId,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _remoteDataSource.getCategories(
        search: search,
        parentId: parentId,
        page: page,
        perPage: perPage,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ContentCategory>> getCategoryById(String id) async {
    try {
      final response = await _remoteDataSource.getCategoryById(id);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ContentCategory>> createCategory(
    ContentCategory category,
  ) async {
    try {
      final model = ContentCategoryModel.fromEntity(category);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('content_count');
      data.remove('created_at');
      data.remove('updated_at');
      data.remove('parent_category_name');

      final response = await _remoteDataSource.createCategory(data);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ContentCategory>> updateCategory(
    ContentCategory category,
  ) async {
    try {
      final model = ContentCategoryModel.fromEntity(category);
      final data = model.toJson();
      // Hapus field read-only yang tidak perlu dikirim ke server.
      data.remove('id');
      data.remove('content_count');
      data.remove('created_at');
      data.remove('updated_at');
      data.remove('parent_category_name');

      final response = await _remoteDataSource.updateCategory(
        category.id,
        data,
      );
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) async {
    try {
      await _remoteDataSource.deleteCategory(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
