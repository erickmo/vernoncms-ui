import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

/// Halaman login aplikasi.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>()..loadRememberedUsername(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: _onStateChanged,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spacingL),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    state.whenOrNull(
      success: () => context.go('/dashboard'),
      error: (message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        const SizedBox(height: AppDimensions.spacingXL),
        _buildCard(context),
      ],
    );
  }

  Widget _buildHeader() => const Column(
        children: [
          Icon(
            Icons.dashboard_customize,
            size: AppDimensions.avatarL,
            color: AppColors.primary,
          ),
          SizedBox(height: AppDimensions.spacingM),
          Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingXS),
          Text(
            AppStrings.loginSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      );

  Widget _buildCard(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => current is LoginInitial,
      builder: (context, state) {
        final initialUsername =
            state is LoginInitial ? state.rememberedUsername : '';
        final initialRememberMe =
            state is LoginInitial ? state.rememberMe : false;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingL),
            child: LoginForm(
              initialUsername: initialUsername,
              initialRememberMe: initialRememberMe,
              onForgotPassword: () => context.go('/forgot-password'),
            ),
          ),
        );
      },
    );
  }
}
