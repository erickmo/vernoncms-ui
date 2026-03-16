import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

/// Sidebar form halaman (kanan): SEO, Settings, Navigation.
class PageFormSidebar extends StatelessWidget {
  // SEO fields
  final TextEditingController metaTitleController;
  final TextEditingController metaDescriptionController;
  final TextEditingController metaKeywordsController;
  final TextEditingController ogTitleController;
  final TextEditingController ogDescriptionController;
  final TextEditingController ogImageUrlController;
  final bool noIndex;
  final ValueChanged<bool> onNoIndexChanged;
  final bool noFollow;
  final ValueChanged<bool> onNoFollowChanged;

  // Layout settings
  final String? template;
  final ValueChanged<String?> onTemplateChanged;
  final bool showHeader;
  final ValueChanged<bool> onShowHeaderChanged;
  final bool showFooter;
  final ValueChanged<bool> onShowFooterChanged;
  final bool showBreadcrumbs;
  final ValueChanged<bool> onShowBreadcrumbsChanged;
  final TextEditingController customCssController;

  // Status & Visibility
  final String status;
  final ValueChanged<String> onStatusChanged;
  final String visibility;
  final ValueChanged<String> onVisibilityChanged;

  // Navigation
  final bool showInNav;
  final ValueChanged<bool> onShowInNavChanged;
  final TextEditingController navLabelController;
  final TextEditingController sortOrderController;
  final TextEditingController parentPageIdController;

  // Featured Image
  final TextEditingController featuredImageUrlController;
  final TextEditingController featuredImageAltController;

  // Redirect
  final TextEditingController redirectUrlController;
  final String? redirectType;
  final ValueChanged<String?> onRedirectTypeChanged;

  const PageFormSidebar({
    super.key,
    required this.metaTitleController,
    required this.metaDescriptionController,
    required this.metaKeywordsController,
    required this.ogTitleController,
    required this.ogDescriptionController,
    required this.ogImageUrlController,
    required this.noIndex,
    required this.onNoIndexChanged,
    required this.noFollow,
    required this.onNoFollowChanged,
    required this.template,
    required this.onTemplateChanged,
    required this.showHeader,
    required this.onShowHeaderChanged,
    required this.showFooter,
    required this.onShowFooterChanged,
    required this.showBreadcrumbs,
    required this.onShowBreadcrumbsChanged,
    required this.customCssController,
    required this.status,
    required this.onStatusChanged,
    required this.visibility,
    required this.onVisibilityChanged,
    required this.showInNav,
    required this.onShowInNavChanged,
    required this.navLabelController,
    required this.sortOrderController,
    required this.parentPageIdController,
    required this.featuredImageUrlController,
    required this.featuredImageAltController,
    required this.redirectUrlController,
    required this.redirectType,
    required this.onRedirectTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStatusSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildNavigationSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildLayoutSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildSeoSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildOgSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildFeaturedImageSection(),
        const SizedBox(height: AppDimensions.spacingM),
        _buildRedirectSection(),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageStatusLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String>(
              initialValue: status,
              decoration: const InputDecoration(
                labelText: AppStrings.pageStatusLabel,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'draft',
                  child: Text(AppStrings.pageStatusDraft),
                ),
                DropdownMenuItem(
                  value: 'published',
                  child: Text(AppStrings.pageStatusPublished),
                ),
                DropdownMenuItem(
                  value: 'archived',
                  child: Text(AppStrings.pageStatusArchived),
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
                labelText: AppStrings.pageVisibilityLabel,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'public',
                  child: Text(AppStrings.pageVisibilityPublic),
                ),
                DropdownMenuItem(
                  value: 'private',
                  child: Text(AppStrings.pageVisibilityPrivate),
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

  Widget _buildNavigationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageNavSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            SwitchListTile(
              title: const Text(AppStrings.pageShowInNavLabel),
              value: showInNav,
              onChanged: (value) => onShowInNavChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            TextFormField(
              controller: navLabelController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageNavLabelLabel,
                hintText: AppStrings.pageNavLabelHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: sortOrderController,
              decoration: const InputDecoration(
                labelText: AppStrings.sortOrder,
                hintText: '0',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: parentPageIdController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageParentPageLabel,
                hintText: AppStrings.pageParentPageHint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageLayoutSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String?>(
              initialValue: template,
              decoration: const InputDecoration(
                labelText: AppStrings.pageTemplateLabel,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: null,
                  child: Text(AppStrings.pageTemplateDefault),
                ),
                DropdownMenuItem(
                  value: 'landing',
                  child: Text(AppStrings.pageTemplateLanding),
                ),
                DropdownMenuItem(
                  value: 'sidebar',
                  child: Text(AppStrings.pageTemplateSidebar),
                ),
              ],
              onChanged: onTemplateChanged,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            SwitchListTile(
              title: const Text(AppStrings.pageShowHeaderLabel),
              value: showHeader,
              onChanged: (value) => onShowHeaderChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text(AppStrings.pageShowFooterLabel),
              value: showFooter,
              onChanged: (value) => onShowFooterChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text(AppStrings.pageShowBreadcrumbsLabel),
              value: showBreadcrumbs,
              onChanged: (value) => onShowBreadcrumbsChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppDimensions.spacingS),
            TextFormField(
              controller: customCssController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageCustomCssLabel,
                hintText: AppStrings.pageCustomCssHint,
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.seoSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
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
                labelText: AppStrings.pageMetaKeywordsLabel,
                hintText: AppStrings.pageMetaKeywordsHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            SwitchListTile(
              title: const Text(AppStrings.pageNoIndexLabel),
              value: noIndex,
              onChanged: (value) => onNoIndexChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text(AppStrings.pageNoFollowLabel),
              value: noFollow,
              onChanged: (value) => onNoFollowChanged(value),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOgSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageOgSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: ogTitleController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageOgTitleLabel,
                hintText: AppStrings.pageOgTitleHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: ogDescriptionController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageOgDescriptionLabel,
                hintText: AppStrings.pageOgDescriptionHint,
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: ogImageUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageOgImageUrlLabel,
                hintText: AppStrings.pageOgImageUrlHint,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageFeaturedImageSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: featuredImageUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageFeaturedImageUrlLabel,
                hintText: AppStrings.pageFeaturedImageUrlHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: featuredImageAltController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageFeaturedImageAltLabel,
                hintText: AppStrings.pageFeaturedImageAltHint,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedirectSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.pageRedirectSection,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            TextFormField(
              controller: redirectUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.pageRedirectUrlLabel,
                hintText: AppStrings.pageRedirectUrlHint,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingM),
            DropdownButtonFormField<String?>(
              initialValue: redirectType,
              decoration: const InputDecoration(
                labelText: AppStrings.pageRedirectTypeLabel,
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: null,
                  child: Text(AppStrings.pageRedirectTypeNone),
                ),
                DropdownMenuItem(
                  value: '301',
                  child: Text(AppStrings.pageRedirectType301),
                ),
                DropdownMenuItem(
                  value: '302',
                  child: Text(AppStrings.pageRedirectType302),
                ),
              ],
              onChanged: onRedirectTypeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
