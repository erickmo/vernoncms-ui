import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/content_category.dart';

/// Sidebar form konten (kanan): status, category, tags, SEO, settings.
class ContentFormSidebar extends StatelessWidget {
  /// Status konten saat ini.
  final String status;

  /// Callback saat status berubah.
  final ValueChanged<String> onStatusChanged;

  /// Visibility konten saat ini.
  final String visibility;

  /// Callback saat visibility berubah.
  final ValueChanged<String> onVisibilityChanged;

  /// ID kategori yang dipilih.
  final String? categoryId;

  /// Callback saat kategori berubah.
  final ValueChanged<String?> onCategoryChanged;

  /// Daftar kategori yang tersedia.
  final List<ContentCategory> categories;

  /// Controller untuk tags.
  final TextEditingController tagsController;

  /// Controller untuk featured image URL.
  final TextEditingController featuredImageUrlController;

  /// Controller untuk featured image alt.
  final TextEditingController featuredImageAltController;

  /// Controller untuk meta title.
  final TextEditingController metaTitleController;

  /// Controller untuk meta description.
  final TextEditingController metaDescriptionController;

  /// Controller untuk meta keywords.
  final TextEditingController metaKeywordsController;

  /// Controller untuk OG title.
  final TextEditingController ogTitleController;

  /// Controller untuk OG description.
  final TextEditingController ogDescriptionController;

  /// Controller untuk OG image URL.
  final TextEditingController ogImageUrlController;

  /// Controller untuk template.
  final TextEditingController templateController;

  /// Apakah konten featured.
  final bool isFeatured;

  /// Callback saat featured berubah.
  final ValueChanged<bool> onFeaturedChanged;

  /// Apakah konten pinned.
  final bool isPinned;

  /// Callback saat pinned berubah.
  final ValueChanged<bool> onPinnedChanged;

  /// Apakah komentar diperbolehkan.
  final bool allowComments;

  /// Callback saat allow comments berubah.
  final ValueChanged<bool> onAllowCommentsChanged;

  /// Apakah noIndex aktif.
  final bool noIndex;

  /// Callback saat noIndex berubah.
  final ValueChanged<bool> onNoIndexChanged;

  /// Apakah noFollow aktif.
  final bool noFollow;

  /// Callback saat noFollow berubah.
  final ValueChanged<bool> onNoFollowChanged;

  const ContentFormSidebar({
    super.key,
    required this.status,
    required this.onStatusChanged,
    required this.visibility,
    required this.onVisibilityChanged,
    required this.categoryId,
    required this.onCategoryChanged,
    required this.categories,
    required this.tagsController,
    required this.featuredImageUrlController,
    required this.featuredImageAltController,
    required this.metaTitleController,
    required this.metaDescriptionController,
    required this.metaKeywordsController,
    required this.ogTitleController,
    required this.ogDescriptionController,
    required this.ogImageUrlController,
    required this.templateController,
    required this.isFeatured,
    required this.onFeaturedChanged,
    required this.isPinned,
    required this.onPinnedChanged,
    required this.allowComments,
    required this.onAllowCommentsChanged,
    required this.noIndex,
    required this.onNoIndexChanged,
    required this.noFollow,
    required this.onNoFollowChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPublishSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildCategorySection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildTagsSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildFeaturedImageSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildSettingsSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildSeoSection(),
      ],
    );
  }

  Widget _buildPublishSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.contentPublishSection,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String>(
              initialValue: status,
              decoration: const InputDecoration(
                labelText: AppStrings.contentStatus,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'draft',
                  child: Text(AppStrings.contentStatusDraft),
                ),
                DropdownMenuItem(
                  value: 'published',
                  child: Text(AppStrings.contentStatusPublished),
                ),
                DropdownMenuItem(
                  value: 'archived',
                  child: Text(AppStrings.contentStatusArchived),
                ),
              ],
              onChanged: (value) {
                if (value != null) onStatusChanged(value);
              },
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String>(
              initialValue: visibility,
              decoration: const InputDecoration(
                labelText: AppStrings.contentVisibility,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'public',
                  child: Text(AppStrings.contentVisibilityPublic),
                ),
                DropdownMenuItem(
                  value: 'private',
                  child: Text(AppStrings.contentVisibilityPrivate),
                ),
                DropdownMenuItem(
                  value: 'password_protected',
                  child: Text(AppStrings.contentVisibilityPasswordProtected),
                ),
              ],
              onChanged: (value) {
                if (value != null) onVisibilityChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.contentCategorySection,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String?>(
              initialValue: categoryId,
              decoration: const InputDecoration(
                labelText: AppStrings.contentCategory,
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text(AppStrings.contentNoCategory),
                ),
                ...categories.map(
                  (c) => DropdownMenuItem<String?>(
                    value: c.id,
                    child: Text(c.name),
                  ),
                ),
              ],
              onChanged: onCategoryChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.contentTagsSection,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: tagsController,
              decoration: const InputDecoration(
                labelText: AppStrings.contentTags,
                hintText: AppStrings.contentTagsHint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.contentFeaturedImage,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: featuredImageUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.contentFeaturedImageUrl,
                hintText: AppStrings.contentFeaturedImageUrlHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: featuredImageAltController,
              decoration: const InputDecoration(
                labelText: AppStrings.contentFeaturedImageAlt,
                hintText: AppStrings.contentFeaturedImageAltHint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              AppStrings.contentSettingsSection,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            SwitchListTile(
              title: const Text(AppStrings.contentFeatured),
              value: isFeatured,
              onChanged: onFeaturedChanged,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text(AppStrings.contentPinned),
              value: isPinned,
              onChanged: onPinnedChanged,
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text(AppStrings.contentAllowComments),
              value: allowComments,
              onChanged: onAllowCommentsChanged,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            TextFormField(
              controller: templateController,
              decoration: const InputDecoration(
                labelText: AppStrings.contentTemplate,
                hintText: AppStrings.contentTemplateHint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeoSection() {
    return Card(
      child: ExpansionTile(
        title: const Text(
          AppStrings.seoSection,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingM,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          AppDimensions.spacingM,
          0,
          AppDimensions.spacingM,
          AppDimensions.spacingM,
        ),
        children: [
          TextFormField(
            controller: metaTitleController,
            decoration: const InputDecoration(
              labelText: AppStrings.metaTitle,
              hintText: AppStrings.metaTitleHint,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: metaDescriptionController,
            decoration: const InputDecoration(
              labelText: AppStrings.metaDescriptionLabel,
              hintText: AppStrings.metaDescriptionHint,
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: metaKeywordsController,
            decoration: const InputDecoration(
              labelText: AppStrings.contentMetaKeywords,
              hintText: AppStrings.contentMetaKeywordsHint,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingL),
          const Text(
            AppStrings.contentOgSection,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: ogTitleController,
            decoration: const InputDecoration(
              labelText: AppStrings.contentOgTitle,
              hintText: AppStrings.contentOgTitleHint,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: ogDescriptionController,
            decoration: const InputDecoration(
              labelText: AppStrings.contentOgDescription,
              hintText: AppStrings.contentOgDescriptionHint,
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppDimensions.spacingM),
          TextFormField(
            controller: ogImageUrlController,
            decoration: const InputDecoration(
              labelText: AppStrings.contentOgImageUrl,
              hintText: AppStrings.contentOgImageUrlHint,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingM),
          SwitchListTile(
            title: const Text(AppStrings.contentNoIndex),
            value: noIndex,
            onChanged: onNoIndexChanged,
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            title: const Text(AppStrings.contentNoFollow),
            value: noFollow,
            onChanged: onNoFollowChanged,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
