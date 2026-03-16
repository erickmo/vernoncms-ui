import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/cms_user.dart';
import '../cubit/user_form_cubit.dart';
import '../widgets/user_form_main.dart';
import '../widgets/user_form_sidebar.dart';

/// Halaman form user untuk membuat atau mengedit user.
class UserFormPage extends StatelessWidget {
  /// ID user yang akan diedit. Null jika membuat baru.
  final String? userId;

  const UserFormPage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<UserFormCubit>();
        if (userId != null) {
          cubit.loadUser(userId!);
        }
        return cubit;
      },
      child: _UserFormView(userId: userId),
    );
  }
}

class _UserFormView extends StatefulWidget {
  final String? userId;

  const _UserFormView({this.userId});

  @override
  State<_UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<_UserFormView> {
  final _formKey = GlobalKey<FormState>();

  // Main fields
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _avatarUrlController;

  // Sidebar fields
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String _role = 'editor';
  bool _isActive = true;
  bool _initialized = false;

  bool get _isEditing => widget.userId != null;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _fullNameController = TextEditingController();
    _avatarUrlController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    // Jika create, langsung set initialized.
    if (!_isEditing) {
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _avatarUrlController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _populateFields(CmsUser user) {
    _usernameController.text = user.username;
    _emailController.text = user.email;
    _fullNameController.text = user.fullName;
    _avatarUrlController.text = user.avatarUrl ?? '';
    _role = user.role;
    _isActive = user.isActive;
  }

  CmsUser _buildUserEntity({CmsUser? existing}) {
    final now = DateTime.now();
    return CmsUser(
      id: existing?.id ?? '',
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      fullName: _fullNameController.text.trim(),
      avatarUrl: _avatarUrlController.text.trim().isEmpty
          ? null
          : _avatarUrlController.text.trim(),
      role: _role,
      isActive: _isActive,
      lastLoginAt: existing?.lastLoginAt,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<UserFormCubit>();
    final state = cubit.state;
    final existing = state is UserFormLoaded ? state.user : null;

    final user = _buildUserEntity(existing: existing);

    final success = _isEditing
        ? await cubit.updateUser(user)
        : await cubit.createUser(
            user,
            password: _passwordController.text,
          );

    if (success && mounted) {
      context.go('/users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserFormCubit, UserFormState>(
      listener: _onFormStateChanged,
      builder: (context, state) {
        return state.when(
          initial: () => _buildForm(context),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (user) {
            if (!_initialized) {
              _initialized = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _populateFields(user);
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

  void _onFormStateChanged(BuildContext context, UserFormState state) {
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
            _isEditing ? AppStrings.userUpdated : AppStrings.userCreated,
          ),
          backgroundColor: AppColors.success,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, {bool isSaving = false}) {
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
                  return _buildDesktopLayout();
                }
                return _buildMobileLayout();
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
              onPressed: () => context.go('/users'),
              icon: const Icon(Icons.arrow_back),
              tooltip: AppStrings.back,
            ),
            const SizedBox(width: AppDimensions.spacingS),
            Text(
              _isEditing ? AppStrings.userEdit : AppStrings.userAdd,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
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
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: UserFormMain(
            usernameController: _usernameController,
            emailController: _emailController,
            fullNameController: _fullNameController,
            avatarUrlController: _avatarUrlController,
          ),
        ),
        const SizedBox(width: AppDimensions.spacingL),
        Expanded(
          flex: 1,
          child: UserFormSidebar(
            role: _role,
            onRoleChanged: (value) => setState(() => _role = value),
            isActive: _isActive,
            onActiveChanged: (value) => setState(() => _isActive = value),
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            isCreating: !_isEditing,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UserFormMain(
          usernameController: _usernameController,
          emailController: _emailController,
          fullNameController: _fullNameController,
          avatarUrlController: _avatarUrlController,
        ),
        const SizedBox(height: AppDimensions.spacingL),
        UserFormSidebar(
          role: _role,
          onRoleChanged: (value) => setState(() => _role = value),
          isActive: _isActive,
          onActiveChanged: (value) => setState(() => _isActive = value),
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          isCreating: !_isEditing,
        ),
      ],
    );
  }
}
