import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

/// Kolom utama form user (kiri): username, email, fullName, avatarUrl.
class UserFormMain extends StatelessWidget {
  /// Controller untuk username.
  final TextEditingController usernameController;

  /// Controller untuk email.
  final TextEditingController emailController;

  /// Controller untuk nama lengkap.
  final TextEditingController fullNameController;

  /// Controller untuk avatar URL.
  final TextEditingController avatarUrlController;

  const UserFormMain({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.fullNameController,
    required this.avatarUrlController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.userInfoSection,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            _buildUsernameField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildEmailField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildFullNameField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildAvatarUrlField(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(
        labelText: AppStrings.usernameLabel,
        hintText: AppStrings.usernameHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.usernameRequired;
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: AppStrings.emailLabel,
        hintText: AppStrings.emailHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.emailRequired;
        }
        return null;
      },
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: fullNameController,
      decoration: const InputDecoration(
        labelText: AppStrings.userFullNameLabel,
        hintText: AppStrings.userFullNameHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.userFullNameRequired;
        }
        return null;
      },
    );
  }

  Widget _buildAvatarUrlField() {
    return TextFormField(
      controller: avatarUrlController,
      decoration: const InputDecoration(
        labelText: AppStrings.userAvatarUrlLabel,
        hintText: AppStrings.userAvatarUrlHint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
