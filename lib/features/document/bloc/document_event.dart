import 'dart:io';

import '../data/models/selected_file.dart';

abstract class DocumentEvent {}

class AddSelectedFile extends DocumentEvent {
  final SelectedFile file;

  AddSelectedFile(this.file);
}

class RemoveSelectedFile extends DocumentEvent {
  final int index;
  RemoveSelectedFile(this.index);
}

/// When user selects file
// class SelectFileEvent extends DocumentEvent {
//   final File file;
//   final String name;
//   final double size;
//
//   SelectFileEvent({
//     required this.file,
//     required this.name,
//     required this.size,
//   });
// }

/// When user clicks upload
class UploadFilesEvent extends DocumentEvent {}

/// When upload progress changes
class UploadProgressEvent extends DocumentEvent {
  final double progress;

  UploadProgressEvent(this.progress);
}

class UpdateFileProgress extends DocumentEvent {
  final int index;
  final double progress;

  UpdateFileProgress(this.index, this.progress);
}

/// When user removes file
// class RemoveFileEvent extends DocumentEvent {}
