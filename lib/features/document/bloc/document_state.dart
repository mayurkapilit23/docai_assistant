import 'dart:io';

import 'package:docai_assistant/features/document/data/models/upload_multiple_document_response.dart';

import '../data/models/selected_file.dart';

class DocumentState {
  final bool isLoading;

  // final Map<String, dynamic>? data;
  final UploadMultipleDocumentResponse? uploadMultipleDocumentResponse;
  final String? error;
  final String? message;
  final double progress;
  final double uploaded;

  // final File? selectedFile;
  // final String? selectedFileName;
  // final double? selectedFileSize;
  final List<SelectedFile> selectedFiles;
  final List<SelectedFile> uploadedFiles;

  DocumentState({
    required this.isLoading,
    this.uploadMultipleDocumentResponse,
    this.error,
    this.message,
    required this.progress,
    required this.uploaded,
    // this.selectedFile,
    // this.selectedFileName,
    // this.selectedFileSize,
    this.selectedFiles = const [],
    this.uploadedFiles = const [],
  });

  factory DocumentState.initial() {
    return DocumentState(
      isLoading: false,
      progress: 0,
      uploaded: 0,
      selectedFiles: [],
      uploadedFiles: [],
    );
  }

  DocumentState copyWith({
    bool? isLoading,
    UploadMultipleDocumentResponse? uploadMultipleDocumentResponse,
    String? error,
    String? message,
    double? progress,
    double? uploaded,
    // File? selectedFile,
    // String? selectedFileName,
    // double? selectedFileSize,
    List<SelectedFile>? selectedFiles,
    List<SelectedFile>? uploadedFiles,
  }) {
    return DocumentState(
      isLoading: isLoading ?? this.isLoading,
      uploadMultipleDocumentResponse:
          uploadMultipleDocumentResponse ?? this.uploadMultipleDocumentResponse,
      error: error,
      message: message,
      progress: progress ?? this.progress,
      uploaded: uploaded ?? this.uploaded,
      // selectedFile: selectedFile ?? this.selectedFile,
      // selectedFileName: selectedFileName ?? this.selectedFileName,
      // selectedFileSize: selectedFileSize ?? this.selectedFileSize,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
    );
  }
}
