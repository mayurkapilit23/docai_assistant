class UploadMultipleDocumentResponse {
  String? message;
  int? count;
  List<Documents>? documents;

  UploadMultipleDocumentResponse({this.message, this.count, this.documents});

  UploadMultipleDocumentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['count'] = count;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  int? id;
  String? filename;
  String? originalName;
  String? filePath;
  int? fileSize;
  String? mimeType;
  String? createdAt;

  Documents({
    this.id,
    this.filename,
    this.originalName,
    this.filePath,
    this.fileSize,
    this.mimeType,
    this.createdAt,
  });

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    originalName = json['original_name'];
    filePath = json['file_path'];
    fileSize = json['file_size'];
    mimeType = json['mime_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['original_name'] = originalName;
    data['file_path'] = filePath;
    data['file_size'] = fileSize;
    data['mime_type'] = mimeType;
    data['created_at'] = createdAt;
    return data;
  }
}
