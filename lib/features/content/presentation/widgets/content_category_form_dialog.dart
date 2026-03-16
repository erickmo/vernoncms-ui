import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/content_category.dart';

/// Dialog form untuk membuat atau mengedit kategori konten.
class ContentCategoryFormDialog extends StatefulWidget {
  /// Kategori yang akan diedit. Null jika membuat baru.
  final ContentCategory? category;

  /// Daftar kategori yang tersedia untuk parent dropdown.
  final List<ContentCategory> availableParents;

  /// Callback saat user menekan simpan.
  final ValueChanged<ContentCategory> onSave;

  const ContentCategoryFormDialog({
    super.key,
    this.category,
    required this.availableParents,
    required this.onSave,
  });

  /// Menampilkan dialog form.
  static Future<void> show({
    required BuildContext context,
    ContentCategory? category,
    required List<ContentCategory> availableParents,
    required ValueChanged<ContentCategory> onSave,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ContentCategoryFormDialog(
        category: category,
        availableParents: availableParents,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ContentCategoryFormDialog> createState() =>
      _ContentCategoryFormDialogState();
}

class _ContentCategoryFormDialogState extends State<ContentCategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _slugController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _sortOrderController;
  late final TextEditingController _iconController;
  late final TextEditingController _colorController;
  late final TextEditingController _metaTitleController;
  late final TextEditingController _metaDescriptionController;

  String? _parentCategoryId;
  bool _isVisible = true;
  bool _isFeatured = false;
  bool _autoSlug = true;
  bool _seoExpanded = false;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    _nameController = TextEditingController(text: category?.name ?? '');
    _slugController = TextEditingController(text: category?.slug ?? '');
    _descriptionController =
        TextEditingController(text: category?.description ?? '');
    _sortOrderController =
        TextEditingController(text: '${category?.sortOrder ?? 0}');
    _iconController = TextEditingController(text: category?.icon ?? '');
    _colorController = TextEditingController(text: category?.color ?? '');
    _metaTitleController =
        TextEditingController(text: category?.metaTitle ?? '');
    _metaDescriptionController =
        TextEditingController(text: category?.metaDescription ?? '');
    _parentCategoryId = category?.parentCategoryId;
    _isVisible = category?.isVisible ?? true;
    _isFeatured = category?.isFeatured ?? false;
    _autoSlug = category == null;

    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    _sortOrderController.dispose();
    _iconController.dispose();
    _colorController.dispose();
    _metaTitleController.dispose();
    _metaDescriptionController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    if (_autoSlug) {
      _slugController.text = _generateSlug(_nameController.text);
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

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final category = ContentCategory(
      id: widget.category?.id ?? '',
      name: _nameController.text.trim(),
      slug: _slugController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      parentCategoryId: _parentCategoryId,
      sortOrder: int.tryParse(_sortOrderController.text) ?? 0,
      icon: _iconController.text.trim().isEmpty
          ? null
          : _iconController.text.trim(),
      color: _colorController.text.trim().isEmpty
          ? null
          : _colorController.text.trim(),
      metaTitle: _metaTitleController.text.trim().isEmpty
          ? null
          : _metaTitleController.text.trim(),
      metaDescription: _metaDescriptionController.text.trim().isEmpty
          ? null
          : _metaDescriptionController.text.trim(),
      isVisible: _isVisible,
      isFeatured: _isFeatured,
      contentCount: widget.category?.contentCount ?? 0,
      createdAt: widget.category?.createdAt ?? now,
      updatedAt: now,
    );

    widget.onSave(category);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _isEditing
            ? AppStrings.editCategory
            : AppStrings.addCategory,
      ),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNameField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildSlugField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildDescriptionField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildParentDropdown(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildSortOrderField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildIconField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildColorField(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildToggles(),
                const SizedBox(height: AppDimensions.spacingM),
                _buildSeoSection(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: _onSave,
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: AppStrings.categoryName,
        hintText: AppStrings.categoryNameHint,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.categoryNameRequired;
        }
        return null;
      },
    );
  }

  Widget _buildSlugField() {
    return TextFormField(
      controller: _slugController,
      decoration: const InputDecoration(
        labelText: AppStrings.categorySlug,
        hintText: AppStrings.categorySlugHint,
        border: OutlineInputBorder(),
      ),
      onChanged: (_) {
        _autoSlug = false;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.categorySlugRequired;
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: AppStrings.categoryDescription,
        hintText: AppStrings.categoryDescriptionHint,
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget _buildParentDropdown() {
    // Filter diri sendiri dari daftar parent.
    final parents = widget.availableParents
        .where((c) => c.id != widget.category?.id)
        .toList();

    return DropdownButtonFormField<String?>(
      initialValue: _parentCategoryId,
      decoration: const InputDecoration(
        labelText: AppStrings.parentCategory,
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem<String?>(
          value: null,
          child: Text(AppStrings.noParentCategory),
        ),
        ...parents.map(
          (c) => DropdownMenuItem<String?>(
            value: c.id,
            child: Text(c.name),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _parentCategoryId = value;
        });
      },
    );
  }

  Widget _buildSortOrderField() {
    return TextFormField(
      controller: _sortOrderController,
      decoration: const InputDecoration(
        labelText: AppStrings.sortOrder,
        hintText: '0',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildIconField() {
    return TextFormField(
      controller: _iconController,
      decoration: const InputDecoration(
        labelText: AppStrings.categoryIcon,
        hintText: AppStrings.categoryIconHint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildColorField() {
    return TextFormField(
      controller: _colorController,
      decoration: const InputDecoration(
        labelText: AppStrings.categoryColor,
        hintText: AppStrings.categoryColorHint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildToggles() {
    return Row(
      children: [
        Expanded(
          child: SwitchListTile(
            title: const Text(AppStrings.categoryVisible),
            value: _isVisible,
            onChanged: (value) {
              setState(() {
                _isVisible = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: AppDimensions.spacingM),
        Expanded(
          child: SwitchListTile(
            title: const Text(AppStrings.categoryFeatured),
            value: _isFeatured,
            onChanged: (value) {
              setState(() {
                _isFeatured = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildSeoSection() {
    return ExpansionTile(
      title: const Text(
        AppStrings.seoSection,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      initiallyExpanded: _seoExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          _seoExpanded = expanded;
        });
      },
      tilePadding: EdgeInsets.zero,
      childrenPadding:
          const EdgeInsets.symmetric(vertical: AppDimensions.spacingS),
      children: [
        TextFormField(
          controller: _metaTitleController,
          decoration: const InputDecoration(
            labelText: AppStrings.metaTitle,
            hintText: AppStrings.metaTitleHint,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingM),
        TextFormField(
          controller: _metaDescriptionController,
          decoration: const InputDecoration(
            labelText: AppStrings.metaDescriptionLabel,
            hintText: AppStrings.metaDescriptionHint,
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
