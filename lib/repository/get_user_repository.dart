import 'package:turkesh_marketer/api/get_user_data_service.dart';
import 'package:turkesh_marketer/model/get_user_data.dart';

class UserRepository {
  final UserService userService;

  UserRepository({required this.userService});

  Future<UserModel> getUser(String email, String token) async {
    final data = await userService.fetchUserData(email, token);
    return UserModel.fromJson(data['user']);
  }
}
