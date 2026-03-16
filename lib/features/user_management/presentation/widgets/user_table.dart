import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/cms_user.dart';

/// Tabel data user.
class UserTable extends StatelessWidget {
  /// Daftar user yang ditampilkan.
  final List<CmsUser> users;

  /// Callback saat user menekan tombol edit.
  final ValueChanged<CmsUser> onEdit;

  /// Callback saat user menekan tombol hapus.
  final ValueChanged<CmsUser> onDelete;

  /// Callback saat user menekan tombol toggle active.
  final ValueChanged<CmsUser> onToggleActive;

  /// Callback saat user menekan tombol reset password.
  final ValueChanged<CmsUser> onResetPassword;

  const UserTable({
    super.key,
    required this.users,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return _buildEmpty();
    }

    return Card(
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            AppColors.primary.withValues(alpha: 0.05),
          ),
          columns: const [
            DataColumn(label: Text(AppStrings.userColumnName)),
            DataColumn(label: Text(AppStrings.userColumnEmail)),
            DataColumn(label: Text(AppStrings.userColumnRole)),
            DataColumn(label: Text(AppStrings.userColumnStatus)),
            DataColumn(label: Text(AppStrings.userColumnLastLogin)),
            DataColumn(label: Text(AppStrings.columnActions)),
          ],
          rows: users.map((user) => _buildRow(user)).toList(),
        ),
      ),
    );
  }

  DataRow _buildRow(CmsUser user) {
    return DataRow(
      cells: [
        DataCell(_buildNameCell(user)),
        DataCell(Text(user.email)),
        DataCell(_buildRoleChip(user.role)),
        DataCell(_buildStatusChip(user.isActive)),
        DataCell(Text(_formatDate(user.lastLoginAt))),
        DataCell(_buildActions(user)),
      ],
    );
  }

  Widget _buildNameCell(CmsUser user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: AppDimensions.avatarS / 2,
          backgroundImage:
              user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
          child: user.avatarUrl == null
              ? Text(
                  user.fullName.isNotEmpty
                      ? user.fullName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(fontSize: 12),
                )
              : null,
        ),
        const SizedBox(width: AppDimensions.spacingS),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.fullName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '@${user.username}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip(String role) {
    final Color chipColor;
    final String label;

    switch (role) {
      case 'super_admin':
        chipColor = AppColors.error;
        label = 'Super Admin';
      case 'admin':
        chipColor = AppColors.primary;
        label = 'Admin';
      case 'editor':
        chipColor = AppColors.success;
        label = 'Editor';
      case 'viewer':
        chipColor = AppColors.info;
        label = 'Viewer';
      default:
        chipColor = AppColors.textHint;
        label = role;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingS,
        vertical: AppDimensions.spacingXS,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: chipColor,
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    final chipColor = isActive ? AppColors.success : AppColors.textHint;
    final label = isActive ? AppStrings.userStatusActive : AppStrings.userStatusInactive;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingS,
        vertical: AppDimensions.spacingXS,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: chipColor,
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  Widget _buildActions(CmsUser user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: AppDimensions.iconS),
          color: AppColors.primary,
          tooltip: AppStrings.edit,
          onPressed: () => onEdit(user),
        ),
        IconButton(
          icon: Icon(
            user.isActive ? Icons.block_outlined : Icons.check_circle_outline,
            size: AppDimensions.iconS,
          ),
          color: user.isActive ? AppColors.warning : AppColors.success,
          tooltip: user.isActive
              ? AppStrings.userDeactivate
              : AppStrings.userActivate,
          onPressed: () => onToggleActive(user),
        ),
        IconButton(
          icon: const Icon(Icons.lock_reset_outlined,
              size: AppDimensions.iconS),
          color: AppColors.info,
          tooltip: AppStrings.userResetPassword,
          onPressed: () => onResetPassword(user),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: AppDimensions.iconS),
          color: AppColors.error,
          tooltip: AppStrings.delete,
          onPressed: () => onDelete(user),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outlined,
              size: AppDimensions.avatarL,
              color: AppColors.textHint,
            ),
            SizedBox(height: AppDimensions.spacingM),
            Text(
              AppStrings.emptyData,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
