import 'dart:io';

class SelectedFile {
  final File file;
  final String name;
  final double size;

  final double progress;
  final bool isUploading;
  final bool isDone;
  final bool isFailed;

  SelectedFile({
    required this.file,
    required this.name,
    required this.size,

    this.progress = 0,
    this.isUploading = false,
    this.isDone = false,
    this.isFailed = false,
  });

  SelectedFile copyWith({
    double? progress,
    bool? isUploading,
    bool? isDone,
    bool? isFailed,
  }) {
    return SelectedFile(
      file: file,
      name: name,
      size: size,
      progress: progress ?? this.progress,
      isUploading: isUploading ?? this.isUploading,
      isDone: isDone ?? this.isDone,
      isFailed: isFailed ?? this.isFailed,
    );
  }
}
