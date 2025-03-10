import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turkesh_marketer/constants/helpers.dart';

class UpdateUserService {
  final String baseUrl =
      "https://turkish.weblayer.info/api/v1.0/profile"; // تأكد من URL الصحيح هنا

  Future<Map<String, dynamic>> updateUserProfile(
      String name, String email, String mobile, String token) async {
    final url = Uri.parse(baseUrl);

    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'mobile': mobile,
      }),
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
  }
}
