import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/domain_builder/domain/entities/domain_definition.dart';
import '../cubit/sidebar_cubit.dart';
import 'cms_sidebar_item.dart';
import 'cms_sidebar_section.dart';

/// Sidebar navigasi utama CMS.
class CmsSidebar extends StatelessWidget {
  const CmsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, SidebarState>(
      builder: (context, state) {
        final width = state.isCollapsed
            ? AppDimensions.sidebarCollapsedWidth
            : AppDimensions.sidebarWidth;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          color: AppColors.sidebarBackground,
          child: Column(
            children: [
              _buildBrandHeader(context, state.isCollapsed),
              const Divider(color: AppColors.sidebarItemActive, height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingS,
                    horizontal: AppDimensions.spacingS,
                  ),
                  child: _buildMenuItems(context, state),
                ),
              ),
              const Divider(color: AppColors.sidebarItemActive, height: 1),
              _buildCollapseToggle(context, state.isCollapsed),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBrandHeader(BuildContext context, bool isCollapsed) => SizedBox(
        height: AppDimensions.appBarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingM,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.dashboard_customize,
                color: AppColors.sidebarTextActive,
                size: AppDimensions.iconL,
              ),
              if (!isCollapsed) ...[
                const SizedBox(width: AppDimensions.spacingS),
                const Expanded(
                  child: Text(
                    AppConstants.appName,
                    style: TextStyle(
                      color: AppColors.sidebarTextActive,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      );

  Widget _buildMenuItems(BuildContext context, SidebarState state) {
    // Group domains by sidebarSection.
    final domainsBySection = <String, List<DomainDefinition>>{};
    for (final domain in state.domains) {
      domainsBySection
          .putIfAbsent(domain.sidebarSection, () => [])
          .add(domain);
    }
    // Sort domains within each section by sidebarOrder.
    for (final list in domainsBySection.values) {
      list.sort((a, b) => a.sidebarOrder.compareTo(b.sidebarOrder));
    }

    // Build domain items for known sections (content, pages).
    List<Widget> contentDomainItems() {
      final domains = domainsBySection['content'] ?? [];
      return domains
          .expand((d) => [
                const SizedBox(height: AppDimensions.spacingXS),
                CmsSidebarItem(
                  icon: _resolveIcon(d.icon),
                  label: d.pluralName,
                  isActive: state.activeRoute == '/domain/${d.slug}',
                  isCollapsed: state.isCollapsed,
                  onTap: () => _navigateTo(context, '/domain/${d.slug}'),
                ),
              ])
          .toList();
    }

    List<Widget> pageDomainItems() {
      final domains = domainsBySection['pages'] ?? [];
      return domains
          .expand((d) => [
                const SizedBox(height: AppDimensions.spacingXS),
                CmsSidebarItem(
                  icon: _resolveIcon(d.icon),
                  label: d.pluralName,
                  isActive: state.activeRoute == '/domain/${d.slug}',
                  isCollapsed: state.isCollapsed,
                  onTap: () => _navigateTo(context, '/domain/${d.slug}'),
                ),
              ])
          .toList();
    }

    // Build custom section widgets for sections that are not content/pages/settings.
    final knownSections = {'content', 'pages', 'settings'};
    final customSections = domainsBySection.keys
        .where((s) => !knownSections.contains(s))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Dashboard
        CmsSidebarItem(
          icon: Icons.dashboard_outlined,
          label: AppStrings.menuDashboard,
          isActive: state.activeRoute == '/dashboard',
          isCollapsed: state.isCollapsed,
          onTap: () => _navigateTo(context, '/dashboard'),
        ),
        const SizedBox(height: AppDimensions.spacingS),

        // Content Section (with dynamic domain items appended)
        CmsSidebarSection(
          title: AppStrings.sectionContent,
          isExpanded: state.expandedSections.contains('content'),
          isSidebarCollapsed: state.isCollapsed,
          onToggle: () =>
              context.read<SidebarCubit>().toggleSection('content'),
          children: [
            CmsSidebarItem(
              icon: Icons.article_outlined,
              label: AppStrings.menuContentList,
              isActive: state.activeRoute == '/content',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/content'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.category_outlined,
              label: AppStrings.menuContentCategory,
              isActive: state.activeRoute == '/content-category',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/content-category'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.perm_media_outlined,
              label: AppStrings.menuMedia,
              isActive: state.activeRoute == '/media',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/media'),
            ),
            ...contentDomainItems(),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingS),

        // Pages Section (with dynamic domain items appended)
        CmsSidebarSection(
          title: AppStrings.sectionPages,
          isExpanded: state.expandedSections.contains('pages'),
          isSidebarCollapsed: state.isCollapsed,
          onToggle: () =>
              context.read<SidebarCubit>().toggleSection('pages'),
          children: [
            CmsSidebarItem(
              icon: Icons.web_outlined,
              label: AppStrings.menuPageList,
              isActive: state.activeRoute == '/pages',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/pages'),
            ),
            ...pageDomainItems(),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingS),

        // Custom domain sections
        ...customSections.expand((section) {
          final domains = domainsBySection[section]!;
          return [
            CmsSidebarSection(
              title: section,
              isExpanded: state.expandedSections.contains(section),
              isSidebarCollapsed: state.isCollapsed,
              onToggle: () =>
                  context.read<SidebarCubit>().toggleSection(section),
              children: domains
                  .expand((d) => [
                        CmsSidebarItem(
                          icon: _resolveIcon(d.icon),
                          label: d.pluralName,
                          isActive:
                              state.activeRoute == '/domain/${d.slug}',
                          isCollapsed: state.isCollapsed,
                          onTap: () =>
                              _navigateTo(context, '/domain/${d.slug}'),
                        ),
                        const SizedBox(height: AppDimensions.spacingXS),
                      ])
                  .toList(),
            ),
            const SizedBox(height: AppDimensions.spacingS),
          ];
        }),

        // Settings Section
        CmsSidebarSection(
          title: AppStrings.sectionSettings,
          isExpanded: state.expandedSections.contains('settings'),
          isSidebarCollapsed: state.isCollapsed,
          onToggle: () =>
              context.read<SidebarCubit>().toggleSection('settings'),
          children: [
            CmsSidebarItem(
              icon: Icons.build_outlined,
              label: AppStrings.menuDomainBuilder,
              isActive: state.activeRoute == '/domain-builder',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/domain-builder'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.people_outlined,
              label: AppStrings.menuUserManagement,
              isActive: state.activeRoute == '/users',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/users'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.settings_outlined,
              label: AppStrings.menuSettings,
              isActive: state.activeRoute == '/settings',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/settings'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.history_outlined,
              label: AppStrings.menuActivityLog,
              isActive: state.activeRoute == '/activity-logs',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/activity-logs'),
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            CmsSidebarItem(
              icon: Icons.key_outlined,
              label: AppStrings.menuApiToken,
              isActive: state.activeRoute == '/api-tokens',
              isCollapsed: state.isCollapsed,
              onTap: () => _navigateTo(context, '/api-tokens'),
            ),
          ],
        ),
      ],
    );
  }

  /// Resolve icon name string to IconData.
  IconData _resolveIcon(String? iconName) {
    if (iconName == null || iconName.isEmpty) return Icons.folder_outlined;
    const iconMap = <String, IconData>{
      'store': Icons.store_outlined,
      'people': Icons.people_outlined,
      'person': Icons.person_outlined,
      'business': Icons.business_outlined,
      'inventory': Icons.inventory_outlined,
      'shopping_cart': Icons.shopping_cart_outlined,
      'local_shipping': Icons.local_shipping_outlined,
      'category': Icons.category_outlined,
      'event': Icons.event_outlined,
      'location': Icons.location_on_outlined,
      'settings': Icons.settings_outlined,
      'star': Icons.star_outlined,
      'favorite': Icons.favorite_outlined,
      'bookmark': Icons.bookmark_outlined,
      'folder': Icons.folder_outlined,
      'description': Icons.description_outlined,
      'assignment': Icons.assignment_outlined,
      'work': Icons.work_outlined,
      'school': Icons.school_outlined,
      'medical_services': Icons.medical_services_outlined,
      'restaurant': Icons.restaurant_outlined,
      'hotel': Icons.hotel_outlined,
      'flight': Icons.flight_outlined,
      'directions_car': Icons.directions_car_outlined,
      'home': Icons.home_outlined,
      'apartment': Icons.apartment_outlined,
      'attach_money': Icons.attach_money,
      'payment': Icons.payment_outlined,
      'receipt': Icons.receipt_outlined,
      'analytics': Icons.analytics_outlined,
      'dashboard': Icons.dashboard_outlined,
      'build': Icons.build_outlined,
      'extension': Icons.extension_outlined,
    };
    return iconMap[iconName] ?? Icons.folder_outlined;
  }

  Widget _buildCollapseToggle(BuildContext context, bool isCollapsed) =>
      InkWell(
        onTap: () => context.read<SidebarCubit>().toggleCollapse(),
        child: SizedBox(
          height: AppDimensions.buttonHeight,
          child: Icon(
            isCollapsed ? Icons.chevron_right : Icons.chevron_left,
            color: AppColors.sidebarText,
          ),
        ),
      );

  void _navigateTo(BuildContext context, String route) {
    context.read<SidebarCubit>().selectRoute(route);
    context.go(route);
  }
}
