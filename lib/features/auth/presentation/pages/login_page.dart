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
      create: (_) => getIt<LoginCubit>()..loadRememberedEmail(),
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
        final initialEmail =
            state is LoginInitial ? state.rememberedEmail : '';
        final initialRememberMe =
            state is LoginInitial ? state.rememberMe : false;
        final successMessage =
            state is LoginInitial ? state.successMessage : '';

        return Column(
          children: [
            if (successMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacingM),
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.spacingS),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: AppColors.success, size: 20),
                      const SizedBox(width: AppDimensions.spacingS),
                      Expanded(
                        child: Text(
                          successMessage,
                          style: const TextStyle(color: AppColors.success),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingL),
                child: LoginForm(
                  initialEmail: initialEmail,
                  initialRememberMe: initialRememberMe,
                  onRegister: () => context.go('/register'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
