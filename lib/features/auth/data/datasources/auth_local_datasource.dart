import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

/// Exception khusus untuk error dari cache/storage.
class CacheException implements Exception {
  /// Pesan error.
  final String message;

  const CacheException(this.message);
}

/// Datasource lokal untuk menyimpan data autentikasi.
abstract class AuthLocalDataSource {
  /// Simpan access token.
  Future<void> saveAccessToken(String token);

  /// Simpan refresh token.
  Future<void> saveRefreshToken(String token);

  /// Ambil access token.
  String? getAccessToken();

  /// Ambil refresh token.
  String? getRefreshToken();

  /// Hapus semua token.
  Future<void> clearTokens();

  /// Simpan username untuk remember me.
  Future<void> saveRememberedUsername(String username);

  /// Ambil username yang disimpan.
  String? getRememberedUsername();

  /// Hapus username yang disimpan.
  Future<void> clearRememberedUsername();
}

/// Implementasi [AuthLocalDataSource] menggunakan SharedPreferences.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _prefs;

  static const String _rememberedUsernameKey = 'remembered_username';

  const AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(AppConstants.accessTokenKey, token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(AppConstants.refreshTokenKey, token);
  }

  @override
  String? getAccessToken() {
    return _prefs.getString(AppConstants.accessTokenKey);
  }

  @override
  String? getRefreshToken() {
    return _prefs.getString(AppConstants.refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await _prefs.remove(AppConstants.accessTokenKey);
    await _prefs.remove(AppConstants.refreshTokenKey);
  }

  @override
  Future<void> saveRememberedUsername(String username) async {
    await _prefs.setString(_rememberedUsernameKey, username);
  }

  @override
  String? getRememberedUsername() {
    return _prefs.getString(_rememberedUsernameKey);
  }

  @override
  Future<void> clearRememberedUsername() async {
    await _prefs.remove(_rememberedUsernameKey);
  }
}
