import 'package:todo_app_test_project/models/user.dart';

abstract class IAuth {
  User login(String email, String password);
  User register(User user);
}
