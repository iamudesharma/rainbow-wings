import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRespository {
  Future<User?> login(String email, String password);
  Future<User?> signUp(String email, String password,String username);
  User? getCurrentUser();
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> changePassword(String password);
  Future<void> deleteUser();
  Future<void> updateUserData(
      String name, String email, String photoUrl, String uid);
}
