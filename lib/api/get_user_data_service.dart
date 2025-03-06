import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkesh_marketer/model/get_user_data.dart';

class UserService {
  static const String baseUrl =
      'https://turkish.weblayer.info/api/v1.0/get-user-data';

  Future<UserModel?> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? email = prefs.getString('email');

      if (token == null || email == null) {
        throw Exception("Token or email not found in SharedPreferences");
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return UserModel.fromJson(data['user']);
        } else {
          throw Exception("Failed to load user data");
        }
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
