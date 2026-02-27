import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/selected_file.dart';
import '../data/repo/document_repo.dart';
import 'document_event.dart';
import 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final DocumentRepo _documentRepo;

  DocumentBloc(this._documentRepo) : super(DocumentState.initial()) {
    on<AddSelectedFile>(_onAddFile);
    on<RemoveSelectedFile>(_onRemoveFile);
    on<UploadFilesEvent>(_onUploadFiles);
    on<UpdateFileProgress>(_onUpdateFileProgress);
  }

  /* ================= ADD FILE ================= */

  void _onAddFile(AddSelectedFile event, Emitter<DocumentState> emit) {
    // Prevent duplicates
    if (state.selectedFiles.any((f) => f.name == event.file.name)) {
      return;
    }

    final updated = List<SelectedFile>.from(state.selectedFiles)
      ..add(event.file);

    emit(
      state.copyWith(
        selectedFiles: updated,
        error: null,
        uploadMultipleDocumentResponse: null,
      ),
    );
  }

  /* ================= REMOVE FILE ================= */

  void _onRemoveFile(RemoveSelectedFile event, Emitter<DocumentState> emit) {
    final updated = List<SelectedFile>.from(state.selectedFiles)
      ..removeAt(event.index);

    emit(state.copyWith(selectedFiles: updated));
  }

  /* ================= UPLOAD FILES ================= */

  Future<void> _onUploadFiles(
    UploadFilesEvent event,
    Emitter<DocumentState> emit,
  ) async {
    if (state.selectedFiles.isEmpty) return;

    emit(state.copyWith(isLoading: true, error: null));

    for (int i = 0; i < state.selectedFiles.length; i++) {
      try {
        // Mark uploading
        _updateStatus(i, isUploading: true, emit: emit);

        await _documentRepo.uploadMultipleFiles(
          file: state.selectedFiles[i].file,
          onProgress: (progress) {
            add(UpdateFileProgress(i, progress));
          },
        );

        // Mark success
        _updateStatus(i, isUploading: false, isDone: true, emit: emit);
      } catch (e) {
        // Mark failed
        _updateStatus(i, isUploading: false, isFailed: true, emit: emit);
      }
    }

    final completedFiles = state.selectedFiles.where((f) => f.isDone).toList();

    emit(
      state.copyWith(
        isLoading: false,
        progress: 1,
        uploadedFiles: [...state.uploadedFiles, ...completedFiles],
        selectedFiles: [], // clear current
      ),
    );

    // emit(state.copyWith(isLoading: false));
  }

  /* ================= PER FILE PROGRESS ================= */

  void _onUpdateFileProgress(
    UpdateFileProgress event,
    Emitter<DocumentState> emit,
  ) {
    final updated = List<SelectedFile>.from(state.selectedFiles);

    updated[event.index] = updated[event.index].copyWith(
      progress: event.progress,
    );

    emit(state.copyWith(selectedFiles: updated));
  }

  /* ================= HELPERS ================= */

  void _updateStatus(
    int index, {
    bool? isUploading,
    bool? isDone,
    bool? isFailed,
    required Emitter<DocumentState> emit,
  }) {
    final updated = List<SelectedFile>.from(state.selectedFiles);

    updated[index] = updated[index].copyWith(
      isUploading: isUploading,
      isDone: isDone,
      isFailed: isFailed,
    );

    emit(state.copyWith(selectedFiles: updated));
  }
}
