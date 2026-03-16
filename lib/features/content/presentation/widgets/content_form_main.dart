import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

/// Kolom utama form konten (kiri): title, slug, excerpt, body.
class ContentFormMain extends StatelessWidget {
  /// Controller untuk judul konten.
  final TextEditingController titleController;

  /// Controller untuk slug konten.
  final TextEditingController slugController;

  /// Controller untuk excerpt konten.
  final TextEditingController excerptController;

  /// Controller untuk body konten.
  final TextEditingController bodyController;

  /// Callback saat slug diubah manual oleh user.
  final VoidCallback onSlugManualEdit;

  const ContentFormMain({
    super.key,
    required this.titleController,
    required this.slugController,
    required this.excerptController,
    required this.bodyController,
    required this.onSlugManualEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildSlugField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildExcerptField(),
            const SizedBox(height: AppDimensions.spacingM),
            _buildBodyField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: titleController,
      decoration: const InputDecoration(
        labelText: AppStrings.contentTitle,
        hintText: AppStrings.contentTitleHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.contentTitleRequired;
        }
        return null;
      },
    );
  }

  Widget _buildSlugField() {
    return TextFormField(
      controller: slugController,
      decoration: const InputDecoration(
        labelText: AppStrings.contentSlug,
        hintText: AppStrings.contentSlugHint,
        border: OutlineInputBorder(),
      ),
      onChanged: (_) => onSlugManualEdit(),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.contentSlugRequired;
        }
        return null;
      },
    );
  }

  Widget _buildExcerptField() {
    return TextFormField(
      controller: excerptController,
      decoration: const InputDecoration(
        labelText: AppStrings.contentExcerpt,
        hintText: AppStrings.contentExcerptHint,
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget _buildBodyField() {
    return TextFormField(
      controller: bodyController,
      decoration: const InputDecoration(
        labelText: AppStrings.contentBody,
        hintText: AppStrings.contentBodyHint,
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      maxLines: 15,
      minLines: 10,
    );
  }
}
