import 'package:todo_app_test_project/models/profile.dart';

abstract class IAuth {
  Future<Profile> login(String email, String password);
  Future<Profile> register(Profile user);
}
