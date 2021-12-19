import 'package:todo_app_test_project/models/user.dart';
import 'package:todo_app_test_project/modules/auth/auth_interface.dart';

class AuthManager {
  IAuth authService;

  AuthManager({required this.authService});

  User login(email, password) {
    User result = authService.login(email, password);
    return result;
  }

  User register(User user) {
    User result = authService.register(user);
    return result;
  }
}
