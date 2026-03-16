import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/cms_user.dart';

/// Kolom sidebar form user (kanan): role, isActive, password.
class UserFormSidebar extends StatelessWidget {
  /// Role yang dipilih saat ini.
  final String role;

  /// Callback saat role berubah.
  final ValueChanged<String> onRoleChanged;

  /// Apakah user aktif.
  final bool isActive;

  /// Callback saat status aktif berubah.
  final ValueChanged<bool> onActiveChanged;

  /// Controller untuk password (hanya untuk create).
  final TextEditingController? passwordController;

  /// Controller untuk konfirmasi password (hanya untuk create).
  final TextEditingController? confirmPasswordController;

  /// Apakah sedang dalam mode create (tampilkan field password).
  final bool isCreating;

  const UserFormSidebar({
    super.key,
    required this.role,
    required this.onRoleChanged,
    required this.isActive,
    required this.onActiveChanged,
    this.passwordController,
    this.confirmPasswordController,
    this.isCreating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRoleCard(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildStatusCard(),
        if (isCreating) ...[
          const SizedBox(height: AppDimensions.spacingM),
          _buildPasswordCard(),
        ],
      ],
    );
  }

  Widget _buildRoleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.userRoleLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            ...UserRole.availableRoles.map((r) => _buildRoleOption(r)),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(UserRole userRole) {
    final isSelected = role == userRole.id;
    final Color chipColor;

    switch (userRole.id) {
      case 'super_admin':
        chipColor = AppColors.error;
      case 'admin':
        chipColor = AppColors.primary;
      case 'editor':
        chipColor = AppColors.success;
      case 'viewer':
        chipColor = AppColors.info;
      default:
        chipColor = AppColors.textHint;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingS),
      child: InkWell(
        onTap: () => onRoleChanged(userRole.id),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? chipColor : AppColors.divider,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            color: isSelected ? chipColor.withValues(alpha: 0.05) : null,
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? chipColor : AppColors.textHint,
                size: AppDimensions.iconM,
              ),
              const SizedBox(width: AppDimensions.spacingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userRole.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? chipColor : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      userRole.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.userActiveLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              value: isActive,
              onChanged: onActiveChanged,
              activeThumbColor: AppColors.success,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.passwordLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.passwordLabel,
                hintText: AppStrings.passwordHint,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (isCreating &&
                    (value == null || value.trim().isEmpty)) {
                  return AppStrings.passwordRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.userConfirmPasswordLabel,
                hintText: AppStrings.userConfirmPasswordHint,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (isCreating) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.userConfirmPasswordRequired;
                  }
                  if (value != passwordController?.text) {
                    return AppStrings.userPasswordMismatch;
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
