import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/page_entity.dart';
import '../cubit/page_form_cubit.dart';
import '../widgets/page_form_main.dart';
import '../widgets/page_form_sidebar.dart';

/// Halaman form untuk membuat atau mengedit halaman CMS.
class PageFormPage extends StatelessWidget {
  /// ID halaman yang akan diedit. Null jika membuat baru.
  final String? pageId;

  const PageFormPage({super.key, this.pageId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<PageFormCubit>();
        if (pageId != null) {
          cubit.loadPage(pageId!);
        }
        return cubit;
      },
      child: _PageFormView(pageId: pageId),
    );
  }
}

class _PageFormView extends StatefulWidget {
  final String? pageId;

  const _PageFormView({this.pageId});

  @override
  State<_PageFormView> createState() => _PageFormViewState();
}

class _PageFormViewState extends State<_PageFormView> {
  final _formKey = GlobalKey<FormState>();

  // Content controllers
  late final TextEditingController _titleController;
  late final TextEditingController _pageKeyController;
  late final TextEditingController _slugController;
  late final TextEditingController _captionController;
  late final TextEditingController _bodyController;

  // Hero controllers
  late final TextEditingController _heroTitleController;
  late final TextEditingController _heroSubtitleController;
  late final TextEditingController _heroImageUrlController;
  late final TextEditingController _heroCtaTextController;
  late final TextEditingController _heroCtaUrlController;

  // SEO controllers
  late final TextEditingController _metaTitleController;
  late final TextEditingController _metaDescriptionController;
  late final TextEditingController _metaKeywordsController;
  late final TextEditingController _ogTitleController;
  late final TextEditingController _ogDescriptionController;
  late final TextEditingController _ogImageUrlController;

  // Layout controllers
  late final TextEditingController _customCssController;

  // Navigation controllers
  late final TextEditingController _navLabelController;
  late final TextEditingController _sortOrderController;
  late final TextEditingController _parentPageIdController;

  // Featured Image controllers
  late final TextEditingController _featuredImageUrlController;
  late final TextEditingController _featuredImageAltController;

  // Redirect controllers
  late final TextEditingController _redirectUrlController;

  // State fields
  bool _noIndex = false;
  bool _noFollow = false;
  String? _template;
  bool _showHeader = true;
  bool _showFooter = true;
  bool _showBreadcrumbs = true;
  String _status = 'draft';
  String _visibility = 'public';
  bool _showInNav = true;
  String? _redirectType;
  bool _autoSlug = true;
  bool _initialized = false;

  bool get _isEditing => widget.pageId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _pageKeyController = TextEditingController();
    _slugController = TextEditingController();
    _captionController = TextEditingController();
    _bodyController = TextEditingController();
    _heroTitleController = TextEditingController();
    _heroSubtitleController = TextEditingController();
    _heroImageUrlController = TextEditingController();
    _heroCtaTextController = TextEditingController();
    _heroCtaUrlController = TextEditingController();
    _metaTitleController = TextEditingController();
    _metaDescriptionController = TextEditingController();
    _metaKeywordsController = TextEditingController();
    _ogTitleController = TextEditingController();
    _ogDescriptionController = TextEditingController();
    _ogImageUrlController = TextEditingController();
    _customCssController = TextEditingController();
    _navLabelController = TextEditingController();
    _sortOrderController = TextEditingController(text: '0');
    _parentPageIdController = TextEditingController();
    _featuredImageUrlController = TextEditingController();
    _featuredImageAltController = TextEditingController();
    _redirectUrlController = TextEditingController();

    _titleController.addListener(_onTitleChanged);

    if (!_isEditing) {
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pageKeyController.dispose();
    _slugController.dispose();
    _captionController.dispose();
    _bodyController.dispose();
    _heroTitleController.dispose();
    _heroSubtitleController.dispose();
    _heroImageUrlController.dispose();
    _heroCtaTextController.dispose();
    _heroCtaUrlController.dispose();
    _metaTitleController.dispose();
    _metaDescriptionController.dispose();
    _metaKeywordsController.dispose();
    _ogTitleController.dispose();
    _ogDescriptionController.dispose();
    _ogImageUrlController.dispose();
    _customCssController.dispose();
    _navLabelController.dispose();
    _sortOrderController.dispose();
    _parentPageIdController.dispose();
    _featuredImageUrlController.dispose();
    _featuredImageAltController.dispose();
    _redirectUrlController.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    if (_autoSlug) {
      _slugController.text = _generateSlug(_titleController.text);
    }
  }

  String _generateSlug(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  void _populateFields(PageEntity page) {
    _titleController.text = page.title;
    _pageKeyController.text = page.pageKey;
    _slugController.text = page.slug;
    _captionController.text = page.caption ?? '';
    _bodyController.text = page.body ?? '';
    _heroTitleController.text = page.heroTitle ?? '';
    _heroSubtitleController.text = page.heroSubtitle ?? '';
    _heroImageUrlController.text = page.heroImageUrl ?? '';
    _heroCtaTextController.text = page.heroCtaText ?? '';
    _heroCtaUrlController.text = page.heroCtaUrl ?? '';
    _metaTitleController.text = page.metaTitle ?? '';
    _metaDescriptionController.text = page.metaDescription ?? '';
    _metaKeywordsController.text = page.metaKeywords.join(', ');
    _ogTitleController.text = page.ogTitle ?? '';
    _ogDescriptionController.text = page.ogDescription ?? '';
    _ogImageUrlController.text = page.ogImageUrl ?? '';
    _customCssController.text = page.customCss ?? '';
    _navLabelController.text = page.navLabel ?? '';
    _sortOrderController.text = '${page.sortOrder}';
    _parentPageIdController.text = page.parentPageId ?? '';
    _featuredImageUrlController.text = page.featuredImageUrl ?? '';
    _featuredImageAltController.text = page.featuredImageAlt ?? '';
    _redirectUrlController.text = page.redirectUrl ?? '';

    setState(() {
      _noIndex = page.noIndex;
      _noFollow = page.noFollow;
      _template = page.template;
      _showHeader = page.showHeader;
      _showFooter = page.showFooter;
      _showBreadcrumbs = page.showBreadcrumbs;
      _status = page.status;
      _visibility = page.visibility;
      _showInNav = page.showInNav;
      _redirectType = page.redirectType;
      _autoSlug = false;
      _initialized = true;
    });
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<PageFormCubit>();
    final now = DateTime.now();

    final keywordsText = _metaKeywordsController.text.trim();
    final metaKeywords = keywordsText.isEmpty
        ? <String>[]
        : keywordsText.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    // Dapatkan halaman lama dari state jika sedang edit.
    PageEntity? existingPage;
    final currentState = cubit.state;
    if (currentState is PageFormLoaded) {
      existingPage = currentState.page;
    }

    final pageEntity = PageEntity(
      id: existingPage?.id ?? '',
      pageKey: _pageKeyController.text.trim(),
      title: _titleController.text.trim(),
      slug: _slugController.text.trim(),
      caption: _captionController.text.trim().isEmpty
          ? null
          : _captionController.text.trim(),
      body: _bodyController.text.trim().isEmpty
          ? null
          : _bodyController.text.trim(),
      heroTitle: _heroTitleController.text.trim().isEmpty
          ? null
          : _heroTitleController.text.trim(),
      heroSubtitle: _heroSubtitleController.text.trim().isEmpty
          ? null
          : _heroSubtitleController.text.trim(),
      heroImageUrl: _heroImageUrlController.text.trim().isEmpty
          ? null
          : _heroImageUrlController.text.trim(),
      heroCtaText: _heroCtaTextController.text.trim().isEmpty
          ? null
          : _heroCtaTextController.text.trim(),
      heroCtaUrl: _heroCtaUrlController.text.trim().isEmpty
          ? null
          : _heroCtaUrlController.text.trim(),
      metaTitle: _metaTitleController.text.trim().isEmpty
          ? null
          : _metaTitleController.text.trim(),
      metaDescription: _metaDescriptionController.text.trim().isEmpty
          ? null
          : _metaDescriptionController.text.trim(),
      metaKeywords: metaKeywords,
      ogTitle: _ogTitleController.text.trim().isEmpty
          ? null
          : _ogTitleController.text.trim(),
      ogDescription: _ogDescriptionController.text.trim().isEmpty
          ? null
          : _ogDescriptionController.text.trim(),
      ogImageUrl: _ogImageUrlController.text.trim().isEmpty
          ? null
          : _ogImageUrlController.text.trim(),
      noIndex: _noIndex,
      noFollow: _noFollow,
      template: _template,
      showHeader: _showHeader,
      showFooter: _showFooter,
      showBreadcrumbs: _showBreadcrumbs,
      customCss: _customCssController.text.trim().isEmpty
          ? null
          : _customCssController.text.trim(),
      status: _status,
      visibility: _visibility,
      parentPageId: _parentPageIdController.text.trim().isEmpty
          ? null
          : _parentPageIdController.text.trim(),
      sortOrder: int.tryParse(_sortOrderController.text) ?? 0,
      showInNav: _showInNav,
      navLabel: _navLabelController.text.trim().isEmpty
          ? null
          : _navLabelController.text.trim(),
      featuredImageUrl: _featuredImageUrlController.text.trim().isEmpty
          ? null
          : _featuredImageUrlController.text.trim(),
      featuredImageAlt: _featuredImageAltController.text.trim().isEmpty
          ? null
          : _featuredImageAltController.text.trim(),
      redirectUrl: _redirectUrlController.text.trim().isEmpty
          ? null
          : _redirectUrlController.text.trim(),
      redirectType: _redirectType,
      publishedAt: _status == 'published'
          ? (existingPage?.publishedAt ?? now)
          : existingPage?.publishedAt,
      createdAt: existingPage?.createdAt ?? now,
      updatedAt: now,
    );

    if (_isEditing) {
      cubit.updatePage(pageEntity);
    } else {
      cubit.createPage(pageEntity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageFormCubit, PageFormState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return state.when(
          initial: () => _buildForm(context, isSaving: false),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (page) {
            if (!_initialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _populateFields(page);
              });
            }
            return _buildForm(context, isSaving: false);
          },
          saving: () => _buildForm(context, isSaving: true),
          saved: (_) => _buildForm(context, isSaving: false),
          error: (message) => _buildForm(context, isSaving: false),
        );
      },
    );
  }

  void _onStateChanged(BuildContext context, PageFormState state) {
    state.whenOrNull(
      saved: (page) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? AppStrings.pageUpdated
                  : AppStrings.pageCreated,
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.go('/pages');
      },
      error: (message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, {required bool isSaving}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormHeader(context, isSaving: isSaving),
            const SizedBox(height: AppDimensions.spacingL),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildMainPanel(),
                      ),
                      const SizedBox(width: AppDimensions.spacingL),
                      Expanded(
                        flex: 2,
                        child: _buildSidebarPanel(),
                      ),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMainPanel(),
                    const SizedBox(height: AppDimensions.spacingL),
                    _buildSidebarPanel(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormHeader(BuildContext context, {required bool isSaving}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/pages'),
              icon: const Icon(Icons.arrow_back),
              tooltip: AppStrings.back,
            ),
            const SizedBox(width: AppDimensions.spacingS),
            Text(
              _isEditing ? AppStrings.editPage : AppStrings.addPage,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: isSaving ? null : () => context.go('/pages'),
              child: const Text(AppStrings.cancel),
            ),
            const SizedBox(width: AppDimensions.spacingS),
            ElevatedButton(
              onPressed: isSaving ? null : _onSave,
              child: isSaving
                  ? const SizedBox(
                      width: AppDimensions.iconS,
                      height: AppDimensions.iconS,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(AppStrings.save),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainPanel() {
    return PageFormMain(
      titleController: _titleController,
      pageKeyController: _pageKeyController,
      slugController: _slugController,
      captionController: _captionController,
      bodyController: _bodyController,
      heroTitleController: _heroTitleController,
      heroSubtitleController: _heroSubtitleController,
      heroImageUrlController: _heroImageUrlController,
      heroCtaTextController: _heroCtaTextController,
      heroCtaUrlController: _heroCtaUrlController,
      onSlugManualEdit: () => _autoSlug = false,
    );
  }

  Widget _buildSidebarPanel() {
    return PageFormSidebar(
      metaTitleController: _metaTitleController,
      metaDescriptionController: _metaDescriptionController,
      metaKeywordsController: _metaKeywordsController,
      ogTitleController: _ogTitleController,
      ogDescriptionController: _ogDescriptionController,
      ogImageUrlController: _ogImageUrlController,
      noIndex: _noIndex,
      onNoIndexChanged: (value) => setState(() => _noIndex = value),
      noFollow: _noFollow,
      onNoFollowChanged: (value) => setState(() => _noFollow = value),
      template: _template,
      onTemplateChanged: (value) => setState(() => _template = value),
      showHeader: _showHeader,
      onShowHeaderChanged: (value) => setState(() => _showHeader = value),
      showFooter: _showFooter,
      onShowFooterChanged: (value) => setState(() => _showFooter = value),
      showBreadcrumbs: _showBreadcrumbs,
      onShowBreadcrumbsChanged: (value) =>
          setState(() => _showBreadcrumbs = value),
      customCssController: _customCssController,
      status: _status,
      onStatusChanged: (value) => setState(() => _status = value),
      visibility: _visibility,
      onVisibilityChanged: (value) => setState(() => _visibility = value),
      showInNav: _showInNav,
      onShowInNavChanged: (value) => setState(() => _showInNav = value),
      navLabelController: _navLabelController,
      sortOrderController: _sortOrderController,
      parentPageIdController: _parentPageIdController,
      featuredImageUrlController: _featuredImageUrlController,
      featuredImageAltController: _featuredImageAltController,
      redirectUrlController: _redirectUrlController,
      redirectType: _redirectType,
      onRedirectTypeChanged: (value) => setState(() => _redirectType = value),
    );
  }
}
