import 'package:flutter/foundation.dart';
import 'package:turkesh_marketer/api/get_user_data_service.dart';
import 'package:turkesh_marketer/model/get_user_data.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<UserModel?> getUserData() async {
    try {
      return await _userService.fetchUserData();
    } catch (e) {
      if (kDebugMode) {
        print("Error in repository: $e");
      }
      return null;
    }
  }
}
