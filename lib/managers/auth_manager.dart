import 'package:todo_app_test_project/models/profile.dart';
import 'package:todo_app_test_project/modules/auth/auth_interface.dart';

class AuthManager {
  IAuth authService;

  AuthManager({required this.authService});

  Future<Profile> login(email, password) async {
    Profile result = await authService.login(email, password);
    return result;
  }

  Future<Profile> register(Profile user) async {
    Profile result = await authService.register(user);
    return result;
  }
}
