import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/utils/contants/api_contants.dart';

class ApiService {
  static Future<dynamic> testApi() async {
    final apiUrl = ApiConstants.getDocs;
    // showLog("getUserProfile ApiUrl: ", apiUrl);

    // showLog("Headers: ", headers);
    try {
      final response = await http.get(Uri.parse(apiUrl));
      // showLog("Api Response:", response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
        // return data["message"];
      } else {
        throw Exception("Server Error");
      }
    } catch (e) {
      // showLog("Api Error:", {e.toString()});
      throw Exception(e);
    }
  }
}
