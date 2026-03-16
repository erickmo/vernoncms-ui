import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

/// Exception khusus untuk error dari server.
class ServerException implements Exception {
  /// Pesan error dari server.
  final String message;

  /// HTTP status code.
  final int? statusCode;

  const ServerException(this.message, {this.statusCode});
}

/// Datasource remote untuk autentikasi.
abstract class AuthRemoteDataSource {
  /// Melakukan login ke server.
  ///
  /// Throws [ServerException] jika gagal.
  Future<LoginResponseModel> login(LoginRequestModel request);
}

/// Implementasi [AuthRemoteDataSource] menggunakan Dio.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  const AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/login',
        data: request.toJson(),
      );

      return LoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = _extractErrorMessage(e);
      throw ServerException(message, statusCode: statusCode);
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
