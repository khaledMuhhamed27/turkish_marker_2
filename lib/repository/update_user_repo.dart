import 'package:turkesh_marketer/api/updat_user_service.dart';

class UpdateUserRepository {
  final UpdateUserService userService;

  UpdateUserRepository({required this.userService});

  // طريقة لتحديث بيانات المستخدم
  Future<Map<String, dynamic>> updateUserProfile(
      String name, String email, String mobile, String token) async {
    try {
      final result = await userService.updateUserProfile(name, email, mobile, token);
      return result; // إرجاع النتيجة الناجحة
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
