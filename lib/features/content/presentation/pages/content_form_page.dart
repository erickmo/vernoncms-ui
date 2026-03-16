import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/content.dart';
import '../../domain/entities/content_category.dart';
import '../cubit/content_category_cubit.dart';
import '../cubit/content_form_cubit.dart';
import '../widgets/content_form_main.dart';
import '../widgets/content_form_sidebar.dart';

/// Halaman form konten untuk membuat atau mengedit konten.
class ContentFormPage extends StatelessWidget {
  /// ID konten yang akan diedit. Null jika membuat baru.
  final String? contentId;

  const ContentFormPage({super.key, this.contentId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final cubit = getIt<ContentFormCubit>();
            if (contentId != null) {
              cubit.loadContent(contentId!);
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (_) => getIt<ContentCategoryCubit>()..loadCategories(),
        ),
      ],
      child: _ContentFormView(contentId: contentId),
    );
  }
}

class _ContentFormView extends StatefulWidget {
  final String? contentId;

  const _ContentFormView({this.contentId});

  @override
  State<_ContentFormView> createState() => _ContentFormViewState();
}

class _ContentFormViewState extends State<_ContentFormView> {
  final _formKey = GlobalKey<FormState>();

  // Main fields
  late final TextEditingController _titleController;
  late final TextEditingController _slugController;
  late final TextEditingController _excerptController;
  late final TextEditingController _bodyController;

  // Sidebar fields
  late final TextEditingController _tagsController;
  late final TextEditingController _featuredImageUrlController;
  late final TextEditingController _featuredImageAltController;
  late final TextEditingController _metaTitleController;
  late final TextEditingController _metaDescriptionController;
  late final TextEditingController _metaKeywordsController;
  late final TextEditingController _ogTitleController;
  late final TextEditingController _ogDescriptionController;
  late final TextEditingController _ogImageUrlController;
  late final TextEditingController _templateController;

  String _status = 'draft';
  String _visibility = 'public';
  String? _categoryId;
  bool _isFeatured = false;
  bool _isPinned = false;
  bool _allowComments = true;
  bool _noIndex = false;
  bool _noFollow = false;
  bool _autoSlug = true;
  bool _initialized = false;

  bool get _isEditing => widget.contentId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _slugController = TextEditingController();
    _excerptController = TextEditingController();
    _bodyController = TextEditingController();
    _tagsController = TextEditingController();
    _featuredImageUrlController = TextEditingController();
    _featuredImageAltController = TextEditingController();
    _metaTitleController = TextEditingController();
    _metaDescriptionController = TextEditingController();
    _metaKeywordsController = TextEditingController();
    _ogTitleController = TextEditingController();
    _ogDescriptionController = TextEditingController();
    _ogImageUrlController = TextEditingController();
    _templateController = TextEditingController();

    _titleController.addListener(_onTitleChanged);

    // Jika create, langsung set initialized.
    if (!_isEditing) {
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _excerptController.dispose();
    _bodyController.dispose();
    _tagsController.dispose();
    _featuredImageUrlController.dispose();
    _featuredImageAltController.dispose();
    _metaTitleController.dispose();
    _metaDescriptionController.dispose();
    _metaKeywordsController.dispose();
    _ogTitleController.dispose();
    _ogDescriptionController.dispose();
    _ogImageUrlController.dispose();
    _templateController.dispose();
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

  void _populateFields(Content content) {
    _titleController.text = content.title;
    _slugController.text = content.slug;
    _excerptController.text = content.excerpt ?? '';
    _bodyController.text = content.body ?? '';
    _tagsController.text = content.tags.join(', ');
    _featuredImageUrlController.text = content.featuredImageUrl ?? '';
    _featuredImageAltController.text = content.featuredImageAlt ?? '';
    _metaTitleController.text = content.metaTitle ?? '';
    _metaDescriptionController.text = content.metaDescription ?? '';
    _metaKeywordsController.text = content.metaKeywords.join(', ');
    _ogTitleController.text = content.ogTitle ?? '';
    _ogDescriptionController.text = content.ogDescription ?? '';
    _ogImageUrlController.text = content.ogImageUrl ?? '';
    _templateController.text = content.template ?? '';
    _status = content.status;
    _visibility = content.visibility;
    _categoryId = content.categoryId;
    _isFeatured = content.isFeatured;
    _isPinned = content.isPinned;
    _allowComments = content.allowComments;
    _noIndex = content.noIndex;
    _noFollow = content.noFollow;
    _autoSlug = false;
  }

  List<String> _parseCommaSeparated(String text) {
    if (text.trim().isEmpty) return [];
    return text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  Content _buildContentEntity({Content? existing}) {
    final now = DateTime.now();
    return Content(
      id: existing?.id ?? '',
      title: _titleController.text.trim(),
      slug: _slugController.text.trim(),
      excerpt: _excerptController.text.trim().isEmpty
          ? null
          : _excerptController.text.trim(),
      body: _bodyController.text.trim().isEmpty
          ? null
          : _bodyController.text.trim(),
      status: _status,
      visibility: _visibility,
      isFeatured: _isFeatured,
      isPinned: _isPinned,
      authorId: existing?.authorId,
      authorName: existing?.authorName,
      categoryId: _categoryId,
      categoryName: existing?.categoryName,
      tags: _parseCommaSeparated(_tagsController.text),
      featuredImageUrl: _featuredImageUrlController.text.trim().isEmpty
          ? null
          : _featuredImageUrlController.text.trim(),
      featuredImageAlt: _featuredImageAltController.text.trim().isEmpty
          ? null
          : _featuredImageAltController.text.trim(),
      metaTitle: _metaTitleController.text.trim().isEmpty
          ? null
          : _metaTitleController.text.trim(),
      metaDescription: _metaDescriptionController.text.trim().isEmpty
          ? null
          : _metaDescriptionController.text.trim(),
      metaKeywords: _parseCommaSeparated(_metaKeywordsController.text),
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
      allowComments: _allowComments,
      template: _templateController.text.trim().isEmpty
          ? null
          : _templateController.text.trim(),
      readingTimeMinutes: existing?.readingTimeMinutes,
      version: existing?.version ?? 1,
      publishedAt: _status == 'published'
          ? (existing?.publishedAt ?? now)
          : existing?.publishedAt,
      scheduledAt: existing?.scheduledAt,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<ContentFormCubit>();
    final state = cubit.state;
    final existing =
        state is ContentFormLoaded ? state.content : null;

    final content = _buildContentEntity(existing: existing);

    final success = _isEditing
        ? await cubit.updateContent(content)
        : await cubit.createContent(content);

    if (success && mounted) {
      context.go('/content');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentFormCubit, ContentFormState>(
      listener: _onFormStateChanged,
      builder: (context, state) {
        return state.when(
          initial: () => _buildForm(context),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (content) {
            if (!_initialized) {
              _initialized = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _populateFields(content);
                  });
                }
              });
            }
            return _buildForm(context);
          },
          saving: () => _buildForm(context, isSaving: true),
          saved: (_) => _buildForm(context),
          error: (message) => _buildForm(context),
        );
      },
    );
  }

  void _onFormStateChanged(BuildContext context, ContentFormState state) {
    state.whenOrNull(
      error: (message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      ),
      saved: (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? AppStrings.contentUpdated
                : AppStrings.contentCreated,
          ),
          backgroundColor: AppColors.success,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, {bool isSaving = false}) {
    final categories =
        context.watch<ContentCategoryCubit>().state is ContentCategoryLoaded
            ? (context.watch<ContentCategoryCubit>().state
                    as ContentCategoryLoaded)
                .categories
            : <ContentCategory>[];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isSaving),
            const SizedBox(height: AppDimensions.spacingL),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return _buildDesktopLayout(categories);
                }
                return _buildMobileLayout(categories);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSaving) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.go('/content'),
              icon: const Icon(Icons.arrow_back),
              tooltip: AppStrings.back,
            ),
            const SizedBox(width: AppDimensions.spacingS),
            Text(
              _isEditing
                  ? AppStrings.editContent
                  : AppStrings.addContent,
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
            OutlinedButton(
              onPressed: isSaving
                  ? null
                  : () {
                      setState(() {
                        _status = 'draft';
                      });
                      _onSave();
                    },
              child: const Text(AppStrings.contentSaveAsDraft),
            ),
            const SizedBox(width: AppDimensions.spacingS),
            ElevatedButton(
              onPressed: isSaving
                  ? null
                  : () {
                      setState(() {
                        _status = 'published';
                      });
                      _onSave();
                    },
              child: isSaving
                  ? const SizedBox(
                      width: AppDimensions.iconS,
                      height: AppDimensions.iconS,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(AppStrings.contentPublish),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(List<ContentCategory> categories) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ContentFormMain(
            titleController: _titleController,
            slugController: _slugController,
            excerptController: _excerptController,
            bodyController: _bodyController,
            onSlugManualEdit: () => _autoSlug = false,
          ),
        ),
        const SizedBox(width: AppDimensions.spacingL),
        Expanded(
          flex: 1,
          child: ContentFormSidebar(
            status: _status,
            onStatusChanged: (value) => setState(() => _status = value),
            visibility: _visibility,
            onVisibilityChanged: (value) =>
                setState(() => _visibility = value),
            categoryId: _categoryId,
            onCategoryChanged: (value) =>
                setState(() => _categoryId = value),
            categories: categories,
            tagsController: _tagsController,
            featuredImageUrlController: _featuredImageUrlController,
            featuredImageAltController: _featuredImageAltController,
            metaTitleController: _metaTitleController,
            metaDescriptionController: _metaDescriptionController,
            metaKeywordsController: _metaKeywordsController,
            ogTitleController: _ogTitleController,
            ogDescriptionController: _ogDescriptionController,
            ogImageUrlController: _ogImageUrlController,
            templateController: _templateController,
            isFeatured: _isFeatured,
            onFeaturedChanged: (value) =>
                setState(() => _isFeatured = value),
            isPinned: _isPinned,
            onPinnedChanged: (value) => setState(() => _isPinned = value),
            allowComments: _allowComments,
            onAllowCommentsChanged: (value) =>
                setState(() => _allowComments = value),
            noIndex: _noIndex,
            onNoIndexChanged: (value) => setState(() => _noIndex = value),
            noFollow: _noFollow,
            onNoFollowChanged: (value) =>
                setState(() => _noFollow = value),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<ContentCategory> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ContentFormMain(
          titleController: _titleController,
          slugController: _slugController,
          excerptController: _excerptController,
          bodyController: _bodyController,
          onSlugManualEdit: () => _autoSlug = false,
        ),
        const SizedBox(height: AppDimensions.spacingL),
        ContentFormSidebar(
          status: _status,
          onStatusChanged: (value) => setState(() => _status = value),
          visibility: _visibility,
          onVisibilityChanged: (value) =>
              setState(() => _visibility = value),
          categoryId: _categoryId,
          onCategoryChanged: (value) =>
              setState(() => _categoryId = value),
          categories: categories,
          tagsController: _tagsController,
          featuredImageUrlController: _featuredImageUrlController,
          featuredImageAltController: _featuredImageAltController,
          metaTitleController: _metaTitleController,
          metaDescriptionController: _metaDescriptionController,
          metaKeywordsController: _metaKeywordsController,
          ogTitleController: _ogTitleController,
          ogDescriptionController: _ogDescriptionController,
          ogImageUrlController: _ogImageUrlController,
          templateController: _templateController,
          isFeatured: _isFeatured,
          onFeaturedChanged: (value) =>
              setState(() => _isFeatured = value),
          isPinned: _isPinned,
          onPinnedChanged: (value) => setState(() => _isPinned = value),
          allowComments: _allowComments,
          onAllowCommentsChanged: (value) =>
              setState(() => _allowComments = value),
          noIndex: _noIndex,
          onNoIndexChanged: (value) => setState(() => _noIndex = value),
          noFollow: _noFollow,
          onNoFollowChanged: (value) =>
              setState(() => _noFollow = value),
        ),
      ],
    );
  }
}
