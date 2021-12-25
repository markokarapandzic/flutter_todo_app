import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_test_project/managers/auth_manager.dart';
import 'package:todo_app_test_project/models/profile.dart';
import 'package:todo_app_test_project/modules/auth/auth_interface.dart';

import 'auth_test.mocks.dart';

@GenerateMocks([IAuth])
void main() {
  group('Auth Module', () {
    late IAuth mockAuthService;
    late AuthManager authManager;

    setUp(() {
      mockAuthService = MockIAuth();
      authManager = AuthManager(authService: mockAuthService);
    });

    test('Should login user', () async {
      Profile expectedUser = Profile('test', 'test@gmail.com', 'tes123');

      when(mockAuthService.login('test@gmail.com', 'test123'))
          .thenAnswer((_) async => expectedUser);

      Profile result = await authManager.login('test@gmail.com', 'test123');

      expect(result, expectedUser);
    });

    test('Should register user', () async {
      Profile newUser = Profile('NewUser', 'new@gmail.com', 'new123');

      when(mockAuthService.register(newUser)).thenAnswer((_) async => newUser);

      Profile registeredUser = await authManager.register(newUser);

      expect(registeredUser, newUser);
    });
  });
}
