import 'dart:async';
import 'dart:io';
import 'package:docai_assistant/core/theme/app_colors.dart';
import 'package:docai_assistant/core/widgets/app_button.dart';
import 'package:docai_assistant/core/widgets/common_app_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  double progress = 0.0;
  Timer? timer;

  final double totalSize = 4.2; // MB
  double uploaded = 0.0;

  @override
  void initState() {
    super.initState();
    _startUpload();
  }

  void _startUpload() {
    timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (progress >= 1) {
        timer.cancel();
      } else {
        setState(() {
          progress += 0.01;
          uploaded = totalSize * progress;
        });
      }
    });
  }

  void _cancelUpload() {
    timer?.cancel();

    setState(() {
      progress = 0;
      uploaded = 0;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  File? selectedFile;
  String? selectedFileName;
  double? selectedFileSize;
  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'txt', 'doc', 'docx', 'xls', 'xlsx'],
        withData: false,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);

        final fileName = result.files.single.name;
        final fileSize = result.files.single.size / (1024 * 1024);

        // Optional: Validate Size (50MB max)
        if (fileSize > 50) {
          // _showError("File size must be below 50MB");
          return;
        }

        debugPrint("Selected: $fileName (${fileSize.toStringAsFixed(2)} MB)");

        // TODO: Upload to backend / show preview
        onFileSelected(file, fileName, fileSize);
      }
    } catch (e) {
      debugPrint("File pick error: $e");
    }
  }

  void onFileSelected(File file, String name, double size) {
    setState(() {
      selectedFile = file;
      selectedFileName = name;
      selectedFileSize = size;
    });

    // Later connect API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: CommonAppBar(title: "Upload Document"),
      /* ---------------- APPBAR ---------------- */
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: const BackButton(color: Colors.black),
      //   title: const Text(
      //     "Upload Document",
      //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),

      /* ---------------- BODY ---------------- */
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _uploadBox(),

                      const SizedBox(height: 28),

                      // _currentUploads(),
                      selectedFilePreview(),
                    ],
                  ),
                ),
              ),

              // _processButton(),
              // AppButton(
              //   backgroundColor: AppColors.primary,
              //   onPressed: () {},
              //   label: "Process with AI",
              //   icon: Icons.auto_awesome,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedFilePreview() {
    if (selectedFile == null) return const SizedBox();

    final fileType = getFileType(selectedFileName!);

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getFileIcon(selectedFileName!),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// File Name
                    Text(
                      selectedFileName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 2),

                    /// File Type + Size
                    Text(
                      "$fileType • ${selectedFileSize!.toStringAsFixed(2)} MB",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              /// Remove Button
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    selectedFile = null;
                    selectedFileName = null;
                    selectedFileSize = null;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Progress Bar
          _progressBar(),

          const SizedBox(height: 6),

          /// Progress Info
          _progressInfo(),
        ],
      ),
    );
  }

  /* ---------------- UPLOAD BOX ---------------- */

  Widget _uploadBox() {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(20),
        color: AppColors.primary,
        dashPattern: [10, 2.5],
        strokeWidth: 1,
        // padding: EdgeInsets.all(16),
      ),
      child: Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withOpacity(.1),
              child: Icon(
                Icons.cloud_upload,
                size: 32,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Tap or drag to upload",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 6),

            const Text(
              "PDF, DOCX, or TXT (Max 50MB)",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: pickDocument,
              // onPressed: () {
              //   debugPrint("Select File");
              // },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(.1),
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text("Select File"),
            ),
          ],
        ),
      ),
    );
  }

  //helper methods

  Widget _getFileIcon(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();

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
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color),
    );
  }

  String getFileType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();

    switch (ext) {
      case 'pdf':
        return 'PDF Document';
      case 'doc':
      case 'docx':
        return 'Word Document';
      case 'xls':
      case 'xlsx':
        return 'Excel Document';
      case 'txt':
        return 'Text File';
      default:
        return 'Unknown File';
    }
  }
  /* ---------------- CURRENT UPLOAD ---------------- */

  Widget _currentUploads() {
    if (progress == 0) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _fileIcon(),

              const SizedBox(width: 12),

              Expanded(child: _fileInfo()),

              IconButton(
                onPressed: _cancelUpload,
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _progressBar(),

          const SizedBox(height: 6),

          _progressInfo(),
        ],
      ),
    );
  }

  Widget _fileIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.picture_as_pdf, color: Colors.red),
    );
  }

  Widget _fileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Research_Proposal_Final.pdf",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          "4.2 MB • PDF Document",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _progressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        minHeight: 6,
        value: progress,
        backgroundColor: Colors.blue.shade50,
        valueColor: const AlwaysStoppedAnimation(Color(0xFF1F2AFF)),
      ),
    );
  }

  Widget _progressInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Uploading...",
          style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
        ),

        Text(
          "${(progress * 100).toInt()}%",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),

        Text(
          "${uploaded.toStringAsFixed(1)} MB of $totalSize MB",
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  /* ---------------- PROCESS BUTTON ---------------- */

  Widget _processButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: progress >= 1 ? () {} : null,
            icon: const Icon(Icons.auto_awesome),
            label: const Text("Process with AI"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F2AFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "By uploading, you agree to our Terms of Service. AI results may vary.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
