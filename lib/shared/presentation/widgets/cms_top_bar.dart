import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/di/injection.dart';
import '../../../features/auth/data/datasources/auth_local_datasource.dart';

/// Top bar CMS dengan judul halaman, nama user, dan avatar.
class CmsTopBar extends StatelessWidget {
  /// Judul halaman saat ini.
  final String title;

  const CmsTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.appBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingM),
      child: Row(
        children: [
          _buildMenuButton(context),
          const SizedBox(width: AppDimensions.spacingS),
          _buildTitle(),
          const Spacer(),
          _buildUserSection(context),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 768) {
      return const SizedBox.shrink();
    }
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      );

  Widget _buildUserSection(BuildContext context) => PopupMenuButton<String>(
        offset: const Offset(0, AppDimensions.appBarHeight - 8),
        onSelected: (value) {
          if (value == 'logout') {
            _handleLogout(context);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout, size: AppDimensions.iconM),
                SizedBox(width: AppDimensions.spacingS),
                Text(AppStrings.logout),
              ],
            ),
          ),
        ],
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Admin',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: AppDimensions.spacingS),
            CircleAvatar(
              radius: AppDimensions.avatarS / 2,
              backgroundColor: AppColors.primary,
              child: Text(
                'A',
                style: TextStyle(
                  color: AppColors.surface,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: AppDimensions.spacingXS),
            Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
          ],
        ),
      );

  void _handleLogout(BuildContext context) {
    final localDataSource = getIt<AuthLocalDataSource>();
    localDataSource.clearTokens();
    context.go('/login');
  }
}
