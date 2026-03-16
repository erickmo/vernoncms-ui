import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cms_user.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/toggle_user_active_usecase.dart';
import '../../domain/usecases/reset_user_password_usecase.dart';

part 'user_list_state.dart';
part 'user_list_cubit.freezed.dart';

/// Cubit untuk mengelola state halaman daftar user.
class UserListCubit extends Cubit<UserListState> {
  final GetUsersUseCase _getUsersUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  final ToggleUserActiveUseCase _toggleUserActiveUseCase;
  final ResetUserPasswordUseCase _resetUserPasswordUseCase;

  UserListCubit({
    required GetUsersUseCase getUsersUseCase,
    required DeleteUserUseCase deleteUserUseCase,
    required ToggleUserActiveUseCase toggleUserActiveUseCase,
    required ResetUserPasswordUseCase resetUserPasswordUseCase,
  })  : _getUsersUseCase = getUsersUseCase,
        _deleteUserUseCase = deleteUserUseCase,
        _toggleUserActiveUseCase = toggleUserActiveUseCase,
        _resetUserPasswordUseCase = resetUserPasswordUseCase,
        super(const UserListState.initial());

  /// Memuat daftar user.
  Future<void> loadUsers({
    String? search,
    String? role,
    bool? isActive,
  }) async {
    emit(const UserListState.loading());

    final result = await _getUsersUseCase(
      search: search,
      role: role,
      isActive: isActive,
    );

    result.fold(
      (failure) => emit(UserListState.error(failure.message)),
      (users) => emit(UserListState.loaded(
        users: users,
        searchQuery: search ?? '',
        roleFilter: role ?? '',
        statusFilter: isActive == null
            ? ''
            : (isActive ? 'active' : 'inactive'),
      )),
    );
  }

  /// Menghapus user berdasarkan [id].
  Future<bool> deleteUser(String id) async {
    final result = await _deleteUserUseCase(id);

    return result.fold(
      (failure) {
        emit(UserListState.error(failure.message));
        return false;
      },
      (_) {
        _reloadWithCurrentFilters();
        return true;
      },
    );
  }

  /// Toggle status aktif user.
  Future<bool> toggleUserActive(String id) async {
    final result = await _toggleUserActiveUseCase(id);

    return result.fold(
      (failure) {
        emit(UserListState.error(failure.message));
        return false;
      },
      (_) {
        _reloadWithCurrentFilters();
        return true;
      },
    );
  }

  /// Reset password user.
  Future<bool> resetUserPassword(String id,
      {required String newPassword}) async {
    final result = await _resetUserPasswordUseCase(
      id,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        emit(UserListState.error(failure.message));
        return false;
      },
      (_) => true,
    );
  }

  void _reloadWithCurrentFilters() {
    final currentState = state;
    final search = currentState is UserListLoaded
        ? currentState.searchQuery
        : null;
    final role = currentState is UserListLoaded
        ? currentState.roleFilter
        : null;
    final statusFilter = currentState is UserListLoaded
        ? currentState.statusFilter
        : null;

    bool? isActive;
    if (statusFilter == 'active') {
      isActive = true;
    } else if (statusFilter == 'inactive') {
      isActive = false;
    }

    loadUsers(
      search: search?.isNotEmpty == true ? search : null,
      role: role?.isNotEmpty == true ? role : null,
      isActive: isActive,
    );
  }
}
