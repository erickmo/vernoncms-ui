import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Widget untuk satu item menu di sidebar.
class CmsSidebarItem extends StatelessWidget {
  /// Icon menu.
  final IconData icon;

  /// Label menu.
  final String label;

  /// Apakah item ini aktif.
  final bool isActive;

  /// Apakah sidebar sedang collapsed.
  final bool isCollapsed;

  /// Callback saat item di-tap.
  final VoidCallback onTap;

  const CmsSidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? AppColors.sidebarItemActive : Colors.transparent;
    final textColor =
        isActive ? AppColors.sidebarTextActive : AppColors.sidebarText;

    final child = Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        hoverColor: AppColors.sidebarItemHover,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
            vertical: isCollapsed
                ? AppDimensions.spacingM
                : AppDimensions.spacingS + 2,
          ),
          child: isCollapsed
              ? Center(child: Icon(icon, color: textColor, size: AppDimensions.iconM))
              : Row(
                  children: [
                    Icon(icon, color: textColor, size: AppDimensions.iconM),
                    const SizedBox(width: AppDimensions.spacingS),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );

    if (isCollapsed) {
      return Tooltip(message: label, child: child);
    }
    return child;
  }
}
