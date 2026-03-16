import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_token.dart';

part 'login_response_model.g.dart';

/// Model response dari API login.
@JsonSerializable()
class LoginResponseModel {
  /// JWT access token.
  @JsonKey(name: 'access_token')
  final String accessToken;

  /// JWT refresh token.
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  /// Waktu expired token dalam detik.
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  /// Parse dari JSON map.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  /// Convert ke domain entity.
  AuthToken toEntity() => AuthToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );
}
