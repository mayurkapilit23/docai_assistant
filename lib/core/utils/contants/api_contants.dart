// lib/constants/api_constants.dart

class ApiConstants {
  // Base URL
  static const String baseUrl = "http://192.168.137.1:5000/api";

  // Endpoints
  static const String uploadFile = "$baseUrl/upload";
  // http://localhost:5000/api/documents/
  static const String getDocs = "$baseUrl/documents";
  static const String deleteFile = "$baseUrl/files/delete";
  static const String healthCheck = "$baseUrl/health";
}
