import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

/// Panel utama form halaman (kiri): Konten + Hero.
class PageFormMain extends StatelessWidget {
  /// Controller untuk judul halaman.
  final TextEditingController titleController;

  /// Controller untuk page key.
  final TextEditingController pageKeyController;

  /// Controller untuk slug.
  final TextEditingController slugController;

  /// Controller untuk caption.
  final TextEditingController captionController;

  /// Controller untuk body/konten.
  final TextEditingController bodyController;

  /// Controller untuk hero title.
  final TextEditingController heroTitleController;

  /// Controller untuk hero subtitle.
  final TextEditingController heroSubtitleController;

  /// Controller untuk hero image URL.
  final TextEditingController heroImageUrlController;

  /// Controller untuk hero CTA text.
  final TextEditingController heroCtaTextController;

  /// Controller untuk hero CTA URL.
  final TextEditingController heroCtaUrlController;

  /// Callback saat slug diubah manual (mematikan auto-slug).
  final VoidCallback onSlugManualEdit;

  const PageFormMain({
    super.key,
    required this.titleController,
    required this.pageKeyController,
    required this.slugController,
    required this.captionController,
    required this.bodyController,
    required this.heroTitleController,
    required this.heroSubtitleController,
    required this.heroImageUrlController,
    required this.heroCtaTextController,
    required this.heroCtaUrlController,
    required this.onSlugManualEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildContentSection(),
        const SizedBox(height: AppDimensions.spacingL),
        _buildHeroSection(),
      ],
    );
  }

  Widget _buildContentSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageTabContent,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageTitleLabel,
                hintText: AppStrings.pageTitleHint,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.pageTitleRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: pageKeyController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageKeyLabel,
                hintText: AppStrings.pageKeyHint,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.pageKeyRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: slugController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageSlugLabel,
                hintText: AppStrings.pageSlugHint,
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => onSlugManualEdit(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.pageSlugRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: captionController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageCaptionLabel,
                hintText: AppStrings.pageCaptionHint,
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageBodyLabel,
                hintText: AppStrings.pageBodyHint,
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageTabHero,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: heroTitleController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageHeroTitleLabel,
                hintText: AppStrings.pageHeroTitleHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: heroSubtitleController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageHeroSubtitleLabel,
                hintText: AppStrings.pageHeroSubtitleHint,
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: heroImageUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageHeroImageUrlLabel,
                hintText: AppStrings.pageHeroImageUrlHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: heroCtaTextController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.pageHeroCtaTextLabel,
                      hintText: AppStrings.pageHeroCtaTextHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingM),
                Expanded(
                  child: TextFormField(
                    controller: heroCtaUrlController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.pageHeroCtaUrlLabel,
                      hintText: AppStrings.pageHeroCtaUrlHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
