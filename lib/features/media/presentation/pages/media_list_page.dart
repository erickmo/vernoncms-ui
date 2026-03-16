import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../content/presentation/widgets/delete_confirmation_dialog.dart';
import '../../domain/entities/media_file.dart';
import '../cubit/media_list_cubit.dart';
import '../widgets/media_detail_dialog.dart';
import '../widgets/media_grid.dart';
import '../widgets/media_upload_dialog.dart';

/// Halaman daftar media.
class MediaListPage extends StatelessWidget {
  const MediaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MediaListCubit>()..loadMedia(),
      child: const _MediaListView(),
    );
  }
}

class _MediaListView extends StatefulWidget {
  const _MediaListView();

  @override
  State<_MediaListView> createState() => _MediaListViewState();
}

class _MediaListViewState extends State<_MediaListView> {
  final _searchController = TextEditingController();
  String? _selectedMimeType;
  String? _selectedFolder;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaListCubit, MediaListState>(
      listener: _onStateChanged,
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (files, folders, searchQuery, mimeTypeFilter, folderFilter) =>
            _buildContent(context, files, folders),
        error: (message) => _buildError(context, message),
      ),
    );
  }

  void _onStateChanged(BuildContext context, MediaListState state) {
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
    List<MediaFile> files,
    List<String> folders,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppDimensions.spacingL),
          _buildFilters(context, folders),
          const SizedBox(height: AppDimensions.spacingM),
          MediaGrid(
            files: files,
            onTap: (file) => _showDetailDialog(context, file),
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
          AppStrings.mediaTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _showUploadDialog(context),
          icon: const Icon(Icons.cloud_upload),
          label: const Text(AppStrings.mediaUpload),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, List<String> folders) {
    return Wrap(
      spacing: AppDimensions.spacingM,
      runSpacing: AppDimensions.spacingS,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppStrings.mediaSearch,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _applyFilters(context);
                      },
                    )
                  : null,
            ),
            onSubmitted: (_) => _applyFilters(context),
          ),
        ),
        SizedBox(
          width: 180,
          child: DropdownButtonFormField<String>(
            initialValue: _selectedMimeType,
            decoration: const InputDecoration(
              labelText: AppStrings.mediaTypeFilter,
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: null, child: Text(AppStrings.mediaAllTypes)),
              DropdownMenuItem(value: 'image', child: Text(AppStrings.mediaImages)),
              DropdownMenuItem(
                  value: 'application/pdf', child: Text(AppStrings.mediaDocuments)),
              DropdownMenuItem(value: 'video', child: Text(AppStrings.mediaVideos)),
            ],
            onChanged: (value) {
              setState(() => _selectedMimeType = value);
              _applyFilters(context);
            },
          ),
        ),
        if (folders.isNotEmpty)
          SizedBox(
            width: 180,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedFolder,
              decoration: const InputDecoration(
                labelText: AppStrings.mediaFolder,
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                    value: null, child: Text(AppStrings.mediaAllFolders)),
                ...folders.map(
                  (f) => DropdownMenuItem(value: f, child: Text(f)),
                ),
              ],
              onChanged: (value) {
                setState(() => _selectedFolder = value);
                _applyFilters(context);
              },
            ),
          ),
      ],
    );
  }

  void _applyFilters(BuildContext context) {
    context.read<MediaListCubit>().loadMedia(
          search: _searchController.text.isNotEmpty
              ? _searchController.text
              : null,
          mimeType: _selectedMimeType,
          folder: _selectedFolder,
        );
  }

  void _showUploadDialog(BuildContext context) {
    final cubit = context.read<MediaListCubit>();
    MediaUploadDialog.show(
      context: context,
      onUpload: (data) async {
        final success = await cubit.uploadMedia(data);
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.mediaUploaded)),
          );
        }
      },
    );
  }

  void _showDetailDialog(BuildContext context, MediaFile file) {
    final cubit = context.read<MediaListCubit>();
    MediaDetailDialog.show(
      context: context,
      file: file,
      onUpdate: (alt, caption, folder) async {
        final data = <String, dynamic>{};
        if (alt != null) data['alt'] = alt;
        if (caption != null) data['caption'] = caption;
        if (folder != null) data['folder'] = folder;
        final success = await cubit.updateMedia(file.id, data);
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.mediaUpdated)),
          );
        }
      },
      onDelete: () => _showDeleteDialog(context, file),
    );
  }

  void _showDeleteDialog(BuildContext context, MediaFile file) {
    final cubit = context.read<MediaListCubit>();
    DeleteConfirmationDialog.show(
      context: context,
      title: AppStrings.mediaDelete,
      message: '${AppStrings.mediaDeleteConfirm} "${file.fileName}"?',
      onConfirm: () async {
        final success = await cubit.deleteMedia(file.id);
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.mediaDeleted)),
          );
        }
      },
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
                  context.read<MediaListCubit>().loadMedia(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
}
