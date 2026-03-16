import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../cubit/login_cubit.dart';

/// Form login dengan field username, password, remember me, dan forgot password.
class LoginForm extends StatefulWidget {
  /// Callback saat user tap "Lupa Password?".
  final VoidCallback? onForgotPassword;

  /// Username yang sudah tersimpan dari remember me.
  final String initialUsername;

  /// Apakah remember me aktif dari sebelumnya.
  final bool initialRememberMe;

  const LoginForm({
    super.key,
    this.onForgotPassword,
    this.initialUsername = '',
    this.initialRememberMe = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late bool _rememberMe;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _passwordController = TextEditingController();
    _rememberMe = widget.initialRememberMe;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildUsernameField(),
          const SizedBox(height: AppDimensions.spacingM),
          _buildPasswordField(),
          const SizedBox(height: AppDimensions.spacingS),
          _buildRememberAndForgot(),
          const SizedBox(height: AppDimensions.spacingL),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildUsernameField() => TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          labelText: AppStrings.usernameLabel,
          hintText: AppStrings.usernameHint,
          prefixIcon: Icon(Icons.person_outline),
        ),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return AppStrings.usernameRequired;
          }
          return null;
        },
      );

  Widget _buildPasswordField() => TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: AppStrings.passwordLabel,
          hintText: AppStrings.passwordHint,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () => setState(() {
              _obscurePassword = !_obscurePassword;
            }),
          ),
        ),
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) => _onSubmit(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.passwordRequired;
          }
          return null;
        },
      );

  Widget _buildRememberAndForgot() => Row(
        children: [
          SizedBox(
            height: AppDimensions.buttonHeightS,
            child: Checkbox(
              value: _rememberMe,
              onChanged: (value) => setState(() {
                _rememberMe = value ?? false;
              }),
            ),
          ),
          const Text(AppStrings.rememberMe),
          const Spacer(),
          TextButton(
            onPressed: widget.onForgotPassword,
            child: const Text(AppStrings.forgotPassword),
          ),
        ],
      );

  Widget _buildLoginButton(BuildContext context) {
    final isLoading = context.watch<LoginCubit>().state is LoginLoading;

    return ElevatedButton(
      onPressed: isLoading ? null : () => _onSubmit(context),
      child: isLoading
          ? const SizedBox(
              height: AppDimensions.iconM,
              width: AppDimensions.iconM,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.surface,
              ),
            )
          : const Text(AppStrings.loginButton),
    );
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
            rememberMe: _rememberMe,
          );
    }
  }
}
