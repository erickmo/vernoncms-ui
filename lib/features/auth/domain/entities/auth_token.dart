import 'package:equatable/equatable.dart';

/// Entity token autentikasi.
class AuthToken extends Equatable {
  /// JWT access token.
  final String accessToken;

  /// JWT refresh token.
  final String refreshToken;

  /// Waktu expired token dalam detik.
  final int expiresIn;

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, expiresIn];
}
