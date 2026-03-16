import 'package:equatable/equatable.dart';

/// Parameter untuk login.
class LoginParams extends Equatable {
  /// Username untuk login.
  final String username;

  /// Password untuk login.
  final String password;

  /// Apakah user memilih remember me.
  final bool rememberMe;

  const LoginParams({
    required this.username,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object> get props => [username, password, rememberMe];
}
