import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../models/page_model.dart';

/// Datasource remote untuk halaman CMS.
abstract class PageRemoteDataSource {
  /// Ambil daftar halaman.
  ///
  /// Throws [ServerException] jika gagal.
  Future<List<PageModel>> getPages({
    String? search,
    String? status,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail halaman berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<PageModel> getPageById(String id);

  /// Buat halaman baru.
  ///
  /// Throws [ServerException] jika gagal.
  Future<PageModel> createPage(Map<String, dynamic> data);

  /// Perbarui halaman yang sudah ada.
  ///
  /// Throws [ServerException] jika gagal.
  Future<PageModel> updatePage(String id, Map<String, dynamic> data);

  /// Hapus halaman berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<void> deletePage(String id);
}

/// Implementasi [PageRemoteDataSource] menggunakan Dio.
class PageRemoteDataSourceImpl implements PageRemoteDataSource {
  final ApiClient _apiClient;

  const PageRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<PageModel>> getPages({
    String? search,
    String? status,
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

      final response = await _apiClient.dio.get(
        '/api/pages',
        queryParameters: queryParameters,
      );

      final list = response.data as List<dynamic>;
      return list
          .map((e) => PageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PageModel> getPageById(String id) async {
    try {
      final response = await _apiClient.dio.get('/api/pages/$id');
      return PageModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PageModel> createPage(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/pages',
        data: data,
      );
      return PageModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<PageModel> updatePage(String id, Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.put(
        '/api/pages/$id',
        data: data,
      );
      return PageModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> deletePage(String id) async {
    try {
      await _apiClient.dio.delete('/api/pages/$id');
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
