import 'package:todo_app_test_project/models/user.dart';
import 'package:todo_app_test_project/modules/auth/auth_interface.dart';

class LocalAuth implements IAuth {
  @override
  User login(String email, String password) {
    // TODO: Implement login
    return User('test', email, password);
  }

  @override
  User register(User user) {
    // TODO: Implement register
    return user;
  }
}
