import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

/// Dialog untuk reset password user oleh admin.
class ResetPasswordDialog extends StatefulWidget {
  /// Nama user untuk display.
  final String userName;

  /// Callback saat user konfirmasi reset password.
  final ValueChanged<String> onConfirm;

  const ResetPasswordDialog({
    super.key,
    required this.userName,
    required this.onConfirm,
  });

  /// Menampilkan dialog reset password.
  static Future<void> show({
    required BuildContext context,
    required String userName,
    required ValueChanged<String> onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => ResetPasswordDialog(
        userName: userName,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.lock_reset,
            color: AppColors.info,
            size: AppDimensions.iconL,
          ),
          const SizedBox(width: AppDimensions.spacingS),
          Expanded(
            child: Text(
              '${AppStrings.userResetPassword} - ${widget.userName}',
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: AppStrings.userNewPasswordLabel,
                  hintText: AppStrings.userNewPasswordHint,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.passwordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppDimensions.spacingM),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: AppStrings.userConfirmPasswordLabel,
                  hintText: AppStrings.userConfirmPasswordHint,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.userConfirmPasswordRequired;
                  }
                  if (value != _passwordController.text) {
                    return AppStrings.userPasswordMismatch;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onConfirm(_passwordController.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text(AppStrings.userResetPassword),
        ),
      ],
    );
  }
}
