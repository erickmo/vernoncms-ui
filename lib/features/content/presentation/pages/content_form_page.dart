import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/content.dart';
import '../../domain/entities/content_category.dart';
import '../../../page_management/domain/entities/page_entity.dart';
import '../../../page_management/domain/usecases/get_pages_usecase.dart';
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
  late final TextEditingController _metadataController;

  String _status = 'draft';
  String? _pageId;
  String? _categoryId;
  bool _autoSlug = true;
  bool _initialized = false;

  // Pages loaded from API
  List<PageEntity> _pages = [];

  bool get _isEditing => widget.contentId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _slugController = TextEditingController();
    _excerptController = TextEditingController();
    _bodyController = TextEditingController();
    _metadataController = TextEditingController(text: '{}');

    _titleController.addListener(_onTitleChanged);

    // Jika create, langsung set initialized.
    if (!_isEditing) {
      _initialized = true;
    }

    // Load pages
    _loadPages();
  }

  Future<void> _loadPages() async {
    try {
      final getPagesUseCase = getIt<GetPagesUseCase>();
      final result = await getPagesUseCase();
      result.fold(
        (_) {},
        (pages) {
          if (mounted) {
            setState(() {
              _pages = pages;
            });
          }
        },
      );
    } catch (_) {
      // Ignore page loading errors
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _excerptController.dispose();
    _bodyController.dispose();
    _metadataController.dispose();
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

    // Prettify metadata JSON.
    try {
      const encoder = JsonEncoder.withIndent('  ');
      _metadataController.text = encoder.convert(content.metadata);
    } catch (_) {
      _metadataController.text = '{}';
    }

    _status = content.status;
    _pageId = content.pageId;
    _categoryId = content.categoryId;
    _autoSlug = false;
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    // Parse metadata JSON.
    Map<String, dynamic> metadata;
    try {
      final parsed = json.decode(_metadataController.text.trim());
      if (parsed is Map<String, dynamic>) {
        metadata = parsed;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.contentMetadataInvalid),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.contentMetadataInvalid),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final cubit = context.read<ContentFormCubit>();
    final state = cubit.state;
    final existing =
        state is ContentFormLoaded ? state.content : null;

    final now = DateTime.now();
    final content = Content(
      id: existing?.id ?? '',
      title: _titleController.text.trim(),
      slug: _slugController.text.trim(),
      body: _bodyController.text.trim().isEmpty
          ? null
          : _bodyController.text.trim(),
      excerpt: _excerptController.text.trim().isEmpty
          ? null
          : _excerptController.text.trim(),
      status: _status,
      pageId: _pageId,
      categoryId: _categoryId,
      authorId: existing?.authorId,
      metadata: metadata,
      publishedAt: existing?.publishedAt,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

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
          saved: () => _buildForm(context),
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
      saved: () => ScaffoldMessenger.of(context).showSnackBar(
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
            TextButton(
              onPressed: isSaving ? null : () => context.go('/content'),
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
            pageId: _pageId,
            onPageChanged: (value) =>
                setState(() => _pageId = value),
            pages: _pages,
            categoryId: _categoryId,
            onCategoryChanged: (value) =>
                setState(() => _categoryId = value),
            categories: categories,
            metadataController: _metadataController,
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
          pageId: _pageId,
          onPageChanged: (value) =>
              setState(() => _pageId = value),
          pages: _pages,
          categoryId: _categoryId,
          onCategoryChanged: (value) =>
              setState(() => _categoryId = value),
          categories: categories,
          metadataController: _metadataController,
        ),
      ],
    );
  }
}
