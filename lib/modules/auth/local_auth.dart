import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_test_project/models/profile.dart';
import 'package:todo_app_test_project/modules/auth/auth_interface.dart';

class LocalAuth implements IAuth {
  late final FirebaseAuth firebaseAuth;

  LocalAuth() {
    firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<Profile> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    return Profile('test', email, password);
  }

  @override
  Future<Profile> register(Profile user) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}
