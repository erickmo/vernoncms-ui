import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../models/cms_user_model.dart';

/// Datasource remote untuk user management.
abstract class UserRemoteDataSource {
  /// Ambil daftar user.
  ///
  /// Throws [ServerException] jika gagal.
  Future<List<CmsUserModel>> getUsers({
    String? search,
    String? role,
    bool? isActive,
    int page = 1,
    int perPage = 10,
  });

  /// Ambil detail user berdasarkan [id].
  ///
  /// Throws [ServerException] jika gagal.
  Future<CmsUserModel> getUserById(String id);

  /// Buat user baru.
  ///
  /// Throws [ServerException] jika gagal.
  Future<CmsUserModel> createUser(Map<String, dynamic> data);

  /// Perbarui user yang sudah ada.
  ///
  /// Throws [ServerException] jika gagal.
  Future<CmsUserModel> updateUser(String id, Map<String, dynamic> data);

  /// Hapus user berdasarkan [id] (soft delete).
  ///
  /// Throws [ServerException] jika gagal.
  Future<void> deleteUser(String id);

  /// Toggle status aktif user.
  ///
  /// Throws [ServerException] jika gagal.
  Future<CmsUserModel> toggleUserActive(String id);

  /// Reset password user oleh admin.
  ///
  /// Throws [ServerException] jika gagal.
  Future<void> resetUserPassword(String id, Map<String, dynamic> data);
}

/// Implementasi [UserRemoteDataSource] menggunakan Dio.
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _apiClient;

  const UserRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<CmsUserModel>> getUsers({
    String? search,
    String? role,
    bool? isActive,
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
      if (role != null && role.isNotEmpty) {
        queryParameters['role'] = role;
      }
      if (isActive != null) {
        queryParameters['is_active'] = isActive;
      }

      final response = await _apiClient.dio.get(
        '/api/users',
        queryParameters: queryParameters,
      );

      final list = response.data as List<dynamic>;
      return list
          .map((e) => CmsUserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<CmsUserModel> getUserById(String id) async {
    try {
      final response = await _apiClient.dio.get('/api/users/$id');
      return CmsUserModel.fromJson(
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
  Future<CmsUserModel> createUser(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/users',
        data: data,
      );
      return CmsUserModel.fromJson(
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
  Future<CmsUserModel> updateUser(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiClient.dio.put(
        '/api/users/$id',
        data: data,
      );
      return CmsUserModel.fromJson(
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
  Future<void> deleteUser(String id) async {
    try {
      await _apiClient.dio.delete('/api/users/$id');
    } on DioException catch (e) {
      throw ServerException(
        _extractErrorMessage(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<CmsUserModel> toggleUserActive(String id) async {
    try {
      final response = await _apiClient.dio.put(
        '/api/users/$id/toggle-active',
      );
      return CmsUserModel.fromJson(
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
  Future<void> resetUserPassword(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _apiClient.dio.put(
        '/api/users/$id/reset-password',
        data: data,
      );
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
