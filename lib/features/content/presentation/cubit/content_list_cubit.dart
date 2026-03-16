import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/content.dart';
import '../../domain/usecases/delete_content_usecase.dart';
import '../../domain/usecases/get_contents_usecase.dart';

part 'content_list_state.dart';
part 'content_list_cubit.freezed.dart';

/// Cubit untuk mengelola state halaman daftar konten.
class ContentListCubit extends Cubit<ContentListState> {
  final GetContentsUseCase _getContentsUseCase;
  final DeleteContentUseCase _deleteContentUseCase;

  ContentListCubit({
    required GetContentsUseCase getContentsUseCase,
    required DeleteContentUseCase deleteContentUseCase,
  })  : _getContentsUseCase = getContentsUseCase,
        _deleteContentUseCase = deleteContentUseCase,
        super(const ContentListState.initial());

  /// Memuat daftar konten.
  Future<void> loadContents({
    String? search,
    String? status,
    String? categoryId,
  }) async {
    emit(const ContentListState.loading());

    final result = await _getContentsUseCase(
      search: search,
      status: status,
      categoryId: categoryId,
    );

    result.fold(
      (failure) => emit(ContentListState.error(failure.message)),
      (contents) => emit(ContentListState.loaded(
        contents: contents,
        searchQuery: search ?? '',
        statusFilter: status ?? '',
        categoryFilter: categoryId ?? '',
      )),
    );
  }

  /// Menghapus konten berdasarkan [id].
  Future<bool> deleteContent(String id) async {
    final result = await _deleteContentUseCase(id);

    return result.fold(
      (failure) {
        emit(ContentListState.error(failure.message));
        return false;
      },
      (_) {
        // Refresh daftar setelah berhasil menghapus konten.
        final currentState = state;
        final search = currentState is ContentListLoaded
            ? currentState.searchQuery
            : null;
        final status = currentState is ContentListLoaded
            ? currentState.statusFilter
            : null;
        final categoryId = currentState is ContentListLoaded
            ? currentState.categoryFilter
            : null;
        loadContents(
          search: search?.isNotEmpty == true ? search : null,
          status: status?.isNotEmpty == true ? status : null,
          categoryId: categoryId?.isNotEmpty == true ? categoryId : null,
        );
        return true;
      },
    );
  }
}
