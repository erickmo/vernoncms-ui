import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

/// Model request untuk API login.
@JsonSerializable()
class LoginRequestModel {
  /// Username untuk login.
  final String username;

  /// Password untuk login.
  final String password;

  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  /// Convert ke JSON map.
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
