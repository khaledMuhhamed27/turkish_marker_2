import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/constants/helpers.dart';

class UserService {
  final String baseUrl = "https://turkish.weblayer.info/api/v1.0/get-user-data";

  Future<Map<String, dynamic>> fetchUserData(String email, String token) async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      print("🔵 REQUEST URL: $url");
      print("🟡 HEADERS: ${response.request?.headers}");
      print("🟠 BODY: ${jsonEncode({'email': email})}");
      print("🔴 RESPONSE STATUS: ${response.statusCode}");
      print("🔴 RESPONSE BODY: ${response.body}");

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        throw Exception(transformErrors(jsonResponse));
      }
    } catch (e) {
      throw Exception("⚠️ خطأ أثناء جلب البيانات: $e");
    }
  }
}
