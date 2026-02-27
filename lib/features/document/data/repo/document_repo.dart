import 'dart:io';
import 'package:dio/dio.dart';
import 'package:docai_assistant/features/document/data/models/upload_multiple_document_response.dart';

import '../../../../core/utils/constants/api_constants.dart';
import '../../../../core/utils/helperMethods/logger.dart';

// class DocumentRepo {
//    Future<UploadMultipleDocumentResponse> uploadMultipleFiles(
//     List<File> files,
//   ) async {
//     final apiUrl = ApiConstants.uploadMultipleDoc;
//     showLog("ApiUrl: ", apiUrl);
//     try {
//       var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
//
//       for (var file in files) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             "files", // field name must match backend
//             file.path,
//           ),
//         );
//       }
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       // if (response.statusCode == 200) {}
//       final data = jsonDecode(responseData);
//       showLog("Api Response:", responseData);
//       return UploadMultipleDocumentResponse.fromJson(data);
//     } catch (e) {
//       showLog("Api Error:", {e.toString()});
//       throw Exception(e);
//     }
//   }
// }

class DocumentRepo {
  final Dio _dio = Dio();

  Future<UploadMultipleDocumentResponse> uploadMultipleFiles({
    required File file,
    required Function(double progress) onProgress,
  }) async {
    String fileName = file.path.split('/').last;
    final apiUrl = ApiConstants.uploadMultipleDoc;
    showLog("ApiUrl: ", apiUrl);
    FormData formData = FormData.fromMap({
      "files": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      final response = await _dio.post(
        apiUrl,
        data: formData,
        onSendProgress: (sent, total) {
          double progress = sent / total;
          onProgress(progress);
        },
      );
      // final data = jsonDecode(response.data);
      showLog("Api Response:", response.data);
      return UploadMultipleDocumentResponse.fromJson(response.data);
    } catch (e) {
      showLog("Api Error:", {e.toString()});
      throw Exception(e);
    }
  }
}
