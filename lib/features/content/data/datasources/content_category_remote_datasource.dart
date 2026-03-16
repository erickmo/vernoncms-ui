import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../models/content_category_model.dart';

/// Datasource remote untuk kategori konten.
abstract class ContentCategoryRemoteDataSource {
  /// Ambil daftar kategori konten.
  ///
  /// Throws [ServerException] jika gagal.
  Future<List<ContentCategoryModel>> getCategories({
    String? search,
    String? parentId,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail kategori berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentCategoryModel> getCategoryById(String id);

  /// Buat kategori baru.
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentCategoryModel> createCategory(Map<String, dynamic> data);

  /// Perbarui kategori yang sudah ada.
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentCategoryModel> updateCategory(
    String id,
    Map<String, dynamic> data,
  );

  /// Hapus kategori berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<void> deleteCategory(String id);
}

/// Implementasi [ContentCategoryRemoteDataSource] menggunakan Dio.
class ContentCategoryRemoteDataSourceImpl
    implements ContentCategoryRemoteDataSource {
  final ApiClient _apiClient;

  const ContentCategoryRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ContentCategoryModel>> getCategories({
    String? search,
    String? parentId,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page,
        'per_page': perPage,
      };
      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }
      if (parentId != null && parentId.isNotEmpty) {
        queryParameters['parent_id'] = parentId;
      }

      final response = await _apiClient.dio.get(
        '/api/content-categories',
        queryParameters: queryParameters,
      );

      final list = response.data as List<dynamic>;
      return list
          .map((e) => ContentCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ContentCategoryModel> getCategoryById(String id) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/content-categories/$id',
      );
      return ContentCategoryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ContentCategoryModel> createCategory(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/content-categories',
        data: data,
      );
      return ContentCategoryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ContentCategoryModel> updateCategory(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/api/content-categories/$id',
        data: data,
      );
      return ContentCategoryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _apiClient.dio.delete('/api/content-categories/$id');
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          'Terjadi kesalahan pada server';
    }
    return e.message ?? 'Terjadi kesalahan pada server';
  }
}
