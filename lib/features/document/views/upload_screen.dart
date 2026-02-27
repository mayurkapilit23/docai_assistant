import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_colors.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../bloc/document_bloc.dart';
import '../bloc/document_event.dart';
import '../bloc/document_state.dart';
import '../data/models/selected_file.dart';
import '../data/repo/document_repo.dart';
import 'document_list_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  /* ================= PICK FILE ================= */

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt', 'doc', 'docx', 'xls', 'xlsx'],
    );

    if (result == null) return;

    for (final file in result.files) {
      if (file.path == null) continue;

      final selected = SelectedFile(
        file: File(file.path!),
        name: file.name,
        size: file.size / (1024 * 1024),
      );

      context.read<DocumentBloc>().add(AddSelectedFile(selected));
    }
  }

  /* ================= UPLOAD ================= */

  void _uploadFiles() {
    context.read<DocumentBloc>().add(UploadFilesEvent());
  }

  /* ================= BUILD ================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Upload Document"),
      body: BlocConsumer<DocumentBloc, DocumentState>(
        listener: _listener,
        builder: _builder,
      ),
    );
  }

  /* ================= LISTENER ================= */

  void _listener(BuildContext context, DocumentState state) {
    if (!state.isLoading &&
        state.progress == 1 &&
        state.uploadedFiles.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<DocumentBloc>(),
            child: const DocumentListScreen(),
          ),
        ),
      );
    }

    if (state.error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.error!)));
    }
  }

  /* ================= BUILDER ================= */

  Widget _builder(BuildContext context, DocumentState state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _uploadBox(context),

            const SizedBox(height: 24),

            if (state.selectedFiles.isNotEmpty) ...[
              _fileList(state),
              const SizedBox(height: 16),
              _uploadButton(state),
            ],
          ],
        ),
      ),
    );
  }

  /* ================= UPLOAD BOX ================= */

  Widget _uploadBox(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(20),
        color: AppColors.primary,
        dashPattern: const [10, 2.5],
      ),
      child: Container(
        height: 240,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withOpacity(.1),
              child: const Icon(Icons.cloud_upload, size: 32),
            ),

            const SizedBox(height: 16),

            const Text(
              "Select Documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickFiles,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(.1),
                elevation: 0,
              ),
              child: Text(
                "Browse Files",
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).extension<AppThemeColors>()?.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ================= FILE LIST ================= */

  Widget _fileList(DocumentState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.selectedFiles.length,
        itemBuilder: (context, index) {
          final file = state.selectedFiles[index];

          return _fileTile(file, index);
        },
      ),
    );
  }

  /* ================= FILE TILE ================= */

  Widget _fileTile(SelectedFile file, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _fileIcon(file.name),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "${_fileType(file.name)} • ${file.size.toStringAsFixed(2)} MB",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.read<DocumentBloc>().add(RemoveSelectedFile(index));
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// PER FILE PROGRESS
          LinearProgressIndicator(value: file.progress, minHeight: 6),

          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              file.isUploading
                  ? "Uploading..."
                  : file.isDone
                  ? "Completed"
                  : file.isFailed
                  ? "Failed"
                  : "Pending",
              style: TextStyle(
                fontSize: 12,
                color: file.isFailed
                    ? Colors.red
                    : file.isDone
                    ? Colors.green
                    : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= UPLOAD BUTTON ================= */

  // Widget _uploadButton(DocumentState state) {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: ElevatedButton(
  //       onPressed: state.isLoading ? null : _uploadFiles,
  //       child: const Text("Upload Files"),
  //     ),
  //   );
  // }

  Widget _uploadButton(DocumentState state) {
    // Check if any file is still pending / failed
    final hasPendingFiles = state.selectedFiles.any((f) => !f.isDone);

    // If all files are done → hide button
    if (!hasPendingFiles) return const SizedBox();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isLoading
            ? null
            : () {
                context.read<DocumentBloc>().add(UploadFilesEvent());
              },
        child: const Text("Upload Files"),
      ),
    );
  }

  /* ================= HELPERS ================= */

  Widget _fileIcon(String name) {
    final ext = name.split('.').last.toLowerCase();

    IconData icon;
    Color color;

    switch (ext) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        break;
      case 'doc':
      case 'docx':
        icon = Icons.description;
        color = Colors.blue;
        break;
      case 'xls':
      case 'xlsx':
        icon = Icons.table_chart;
        color = Colors.green;
        break;
      case 'txt':
        icon = Icons.text_snippet;
        color = Colors.orange;
        break;
      default:
        icon = Icons.insert_drive_file;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color),
    );
  }

  String _fileType(String name) {
    final ext = name.split('.').last.toLowerCase();

    switch (ext) {
      case 'pdf':
        return 'PDF';
      case 'doc':
      case 'docx':
        return 'Word';
      case 'xls':
      case 'xlsx':
        return 'Excel';
      case 'txt':
        return 'Text';
      default:
        return 'File';
    }
  }
}
