import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as html;

class ApiService {
  static const String baseUrl = 'http://43.204.144.74:3000/v1';

  // Common GET method
  static Future<dynamic> getRequest(String endpoint,
      {Map<String, String>? params}) async {
    try {
      final isExpired = await TokenService.isExpired();
      if (isExpired && await TokenService.getToken() != null) {
        await TokenService.deleteToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', '');
        await prefs.setString('userid', '');
        await prefs.setBool('isLoggedIn', false);
        isLoggedInvalue = false;
        phoneNumber = '';
        userId = '';
        html.window.location.reload();
      }
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
