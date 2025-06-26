import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';

class ApiService {
  static const String baseUrl = 'http://43.204.144.74:3000/v1';

  // Common GET method
  static Future<dynamic> getRequest(String endpoint,
      {Map<String, String>? params}) async {
    try {
      Uri url = Uri.parse('$baseUrl/$endpoint');

      // Append query parameters if available
      if (params != null && params.isNotEmpty) {
        url = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);
      }

      var response = await http.get(url , headers: {
        "Authorization":"Bearer ${await TokenService.getToken()}"
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Parse JSON response
      } else {
        throw Exception(
            "Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
