import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/page_entity.dart';

/// Tabel data halaman CMS.
class PageTable extends StatelessWidget {
  /// Daftar halaman yang ditampilkan.
  final List<PageEntity> pages;

  /// Callback saat user menekan tombol edit.
  final ValueChanged<PageEntity> onEdit;

  /// Callback saat user menekan tombol hapus.
  final ValueChanged<PageEntity> onDelete;

  const PageTable({
    super.key,
    required this.pages,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
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
            DataColumn(label: Text(AppStrings.pageColumnTitle)),
            DataColumn(label: Text(AppStrings.pageColumnPageKey)),
            DataColumn(label: Text(AppStrings.pageColumnStatus)),
            DataColumn(label: Text(AppStrings.pageColumnShowInNav)),
            DataColumn(label: Text(AppStrings.columnActions)),
          ],
          rows: pages.map((page) => _buildRow(page)).toList(),
        ),
      ),
    );
  }

  DataRow _buildRow(PageEntity page) {
    return DataRow(
      cells: [
        DataCell(_buildTitleCell(page)),
        DataCell(Text(page.pageKey)),
        DataCell(_buildStatusChip(page.status)),
        DataCell(_buildNavChip(page.showInNav)),
        DataCell(_buildActions(page)),
      ],
    );
  }

  Widget _buildTitleCell(PageEntity page) {
    return Flexible(
      child: Text(
        page.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    String label;
    switch (status) {
      case 'published':
        chipColor = AppColors.success;
        label = AppStrings.pageStatusPublished;
      case 'archived':
        chipColor = AppColors.textHint;
        label = AppStrings.pageStatusArchived;
      default:
        chipColor = AppColors.warning;
        label = AppStrings.pageStatusDraft;
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

  Widget _buildNavChip(bool showInNav) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingS,
        vertical: AppDimensions.spacingXS,
      ),
      decoration: BoxDecoration(
        color: showInNav
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.textHint.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        showInNav ? AppStrings.visible : AppStrings.hidden,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: showInNav ? AppColors.success : AppColors.textHint,
        ),
      ),
    );
  }

  Widget _buildActions(PageEntity page) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: AppDimensions.iconS),
          color: AppColors.primary,
          tooltip: AppStrings.edit,
          onPressed: () => onEdit(page),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: AppDimensions.iconS),
          color: AppColors.error,
          tooltip: AppStrings.delete,
          onPressed: () => onDelete(page),
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
              Icons.web_outlined,
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
