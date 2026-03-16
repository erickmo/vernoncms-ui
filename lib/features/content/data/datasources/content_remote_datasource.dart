import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../models/content_model.dart';

/// Datasource remote untuk konten.
abstract class ContentRemoteDataSource {
  /// Ambil daftar konten.
  ///
  /// Throws [ServerException] jika gagal.
  Future<List<ContentModel>> getContents({
    String? search,
    String? status,
    String? categoryId,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail konten berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentModel> getContentById(String id);

  /// Buat konten baru.
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentModel> createContent(Map<String, dynamic> data);

  /// Perbarui konten yang sudah ada.
  ///
  /// Throws [ServerException] jika gagal.
  Future<ContentModel> updateContent(
    String id,
    Map<String, dynamic> data,
  );

  /// Hapus konten berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<void> deleteContent(String id);
}

/// Implementasi [ContentRemoteDataSource] menggunakan Dio.
class ContentRemoteDataSourceImpl implements ContentRemoteDataSource {
  final ApiClient _apiClient;

  const ContentRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ContentModel>> getContents({
    String? search,
    String? status,
    String? categoryId,
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
      if (status != null && status.isNotEmpty) {
        queryParameters['status'] = status;
      }
      if (categoryId != null && categoryId.isNotEmpty) {
        queryParameters['category_id'] = categoryId;
      }

      final response = await _apiClient.dio.get(
        '/api/contents',
        queryParameters: queryParameters,
      );

      final list = response.data as List<dynamic>;
      return list
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ContentModel> getContentById(String id) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/contents/$id',
      );
      return ContentModel.fromJson(
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
  Future<ContentModel> createContent(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/contents',
        data: data,
      );
      return ContentModel.fromJson(
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
  Future<ContentModel> updateContent(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/api/contents/$id',
        data: data,
      );
      return ContentModel.fromJson(
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
  Future<void> deleteContent(String id) async {
    try {
      await _apiClient.dio.delete('/api/contents/$id');
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
