import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/content_category.dart';

/// Tabel data kategori konten.
class ContentCategoryTable extends StatelessWidget {
  /// Daftar kategori yang ditampilkan.
  final List<ContentCategory> categories;

  /// Callback saat user menekan tombol edit.
  final ValueChanged<ContentCategory> onEdit;

  /// Callback saat user menekan tombol hapus.
  final ValueChanged<ContentCategory> onDelete;

  const ContentCategoryTable({
    super.key,
    required this.categories,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
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
            DataColumn(label: Text(AppStrings.columnName)),
            DataColumn(label: Text(AppStrings.columnSlug)),
            DataColumn(
              label: Text(AppStrings.columnContentCount),
              numeric: true,
            ),
            DataColumn(label: Text(AppStrings.columnVisible)),
            DataColumn(label: Text(AppStrings.columnActions)),
          ],
          rows: categories.map((category) => _buildRow(category)).toList(),
        ),
      ),
    );
  }

  DataRow _buildRow(ContentCategory category) {
    return DataRow(
      cells: [
        DataCell(_buildNameCell(category)),
        DataCell(Text(category.slug)),
        DataCell(Text('${category.contentCount}')),
        DataCell(_buildVisibilityChip(category.isVisible)),
        DataCell(_buildActions(category)),
      ],
    );
  }

  Widget _buildNameCell(ContentCategory category) {
    final hasParent = category.parentCategoryId != null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasParent)
          const Padding(
            padding: EdgeInsets.only(right: AppDimensions.spacingS),
            child: Text(
              '  \u2514 ',
              style: TextStyle(color: AppColors.textHint),
            ),
          ),
        if (category.icon != null && category.icon!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.spacingS),
            child: Text(category.icon!),
          ),
        Flexible(
          child: Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilityChip(bool isVisible) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingS,
        vertical: AppDimensions.spacingXS,
      ),
      decoration: BoxDecoration(
        color: isVisible
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.textHint.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        isVisible ? AppStrings.visible : AppStrings.hidden,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isVisible ? AppColors.success : AppColors.textHint,
        ),
      ),
    );
  }

  Widget _buildActions(ContentCategory category) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: AppDimensions.iconS),
          color: AppColors.primary,
          tooltip: AppStrings.edit,
          onPressed: () => onEdit(category),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: AppDimensions.iconS),
          color: AppColors.error,
          tooltip: AppStrings.delete,
          onPressed: () => onDelete(category),
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
              Icons.category_outlined,
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
