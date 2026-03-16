import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Widget untuk section (grup) menu di sidebar yang bisa di-expand/collapse.
class CmsSidebarSection extends StatelessWidget {
  /// Judul section.
  final String title;

  /// Apakah section ini expanded.
  final bool isExpanded;

  /// Apakah sidebar sedang collapsed.
  final bool isSidebarCollapsed;

  /// Callback saat section header di-tap.
  final VoidCallback onToggle;

  /// Item-item di dalam section.
  final List<Widget> children;

  const CmsSidebarSection({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.isSidebarCollapsed,
    required this.onToggle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (isSidebarCollapsed) {
      return Column(
        children: [
          const Divider(color: AppColors.sidebarItemActive, height: 1),
          const SizedBox(height: AppDimensions.spacingS),
          ...children,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        if (isExpanded) ...children,
      ],
    );
  }

  Widget _buildSectionHeader() => InkWell(
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
            vertical: AppDimensions.spacingS,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.sidebarSectionTitle,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: AppColors.sidebarSectionTitle,
                size: AppDimensions.iconS,
              ),
            ],
          ),
        ),
      );
}
