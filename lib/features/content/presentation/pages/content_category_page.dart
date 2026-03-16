import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/content_category.dart';
import '../cubit/content_category_cubit.dart';
import '../widgets/content_category_form_dialog.dart';
import '../widgets/content_category_table.dart';
import '../widgets/delete_confirmation_dialog.dart';

/// Halaman daftar kategori konten.
class ContentCategoryPage extends StatelessWidget {
  const ContentCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ContentCategoryCubit>()..loadCategories(),
      child: const _ContentCategoryView(),
    );
  }
}

class _ContentCategoryView extends StatefulWidget {
  const _ContentCategoryView();

  @override
  State<_ContentCategoryView> createState() => _ContentCategoryViewState();
}

class _ContentCategoryViewState extends State<_ContentCategoryView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentCategoryCubit, ContentCategoryState>(
      listener: _onStateChanged,
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (categories, searchQuery) =>
            _buildContent(context, categories, searchQuery),
        error: (message) => _buildError(context, message),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ContentCategoryState state) {
    state.whenOrNull(
      error: (message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<ContentCategory> categories,
    String searchQuery,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppDimensions.spacingL),
          _buildSearchBar(context),
          const SizedBox(height: AppDimensions.spacingM),
          ContentCategoryTable(
            categories: categories,
            onEdit: (category) => _showFormDialog(
              context,
              category: category,
              allCategories: categories,
            ),
            onDelete: (category) => _showDeleteDialog(context, category),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppStrings.contentCategoryTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            final state = context.read<ContentCategoryCubit>().state;
            final allCategories = state is ContentCategoryLoaded
                ? state.categories
                : <ContentCategory>[];
            _showFormDialog(context, allCategories: allCategories);
          },
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addCategory),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SizedBox(
      width: 360,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: AppStrings.searchCategory,
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context
                        .read<ContentCategoryCubit>()
                        .loadCategories();
                  },
                )
              : null,
        ),
        onSubmitted: (value) {
          context
              .read<ContentCategoryCubit>()
              .loadCategories(search: value.isNotEmpty ? value : null);
        },
      ),
    );
  }

  void _showFormDialog(
    BuildContext context, {
    ContentCategory? category,
    required List<ContentCategory> allCategories,
  }) {
    final cubit = context.read<ContentCategoryCubit>();
    ContentCategoryFormDialog.show(
      context: context,
      category: category,
      availableParents: allCategories,
      onSave: (updatedCategory) {
        if (category != null) {
          cubit.updateCategory(updatedCategory);
        } else {
          cubit.createCategory(updatedCategory);
        }
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ContentCategory category) {
    final cubit = context.read<ContentCategoryCubit>();
    DeleteConfirmationDialog.show(
      context: context,
      title: AppStrings.deleteCategory,
      message: '${AppStrings.deleteCategoryConfirm} "${category.name}"?',
      onConfirm: () => cubit.deleteCategory(category.id),
    );
  }

  Widget _buildError(BuildContext context, String message) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimensions.avatarL,
              color: AppColors.error,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            ElevatedButton(
              onPressed: () =>
                  context.read<ContentCategoryCubit>().loadCategories(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
}
