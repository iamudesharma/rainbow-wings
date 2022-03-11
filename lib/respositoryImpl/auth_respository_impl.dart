import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../respository/auth_respository.dart';

class AuthRespositoryImpl extends AuthRespository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
    ),
  );

  // AuthRespositoryImpl._();

  @override
  Future<void> changePassword(String password) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  User? getCurrentUser()  {
    try {
      _logger.i('getCurrentUser');
      return _auth.currentUser;
    } catch (e) {
      _logger.e('getCurrentUser', e);
      return null;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      _logger.i('login');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      _logger.e('login', e);
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      _logger.i('signOut');
      await _auth.signOut();
    } catch (e) {
      _logger.e('signOut', e);
    }
  }

  @override
  Future<User?> signUp(
    String email,
    String password,
    String username,
  ) async {
    try {
      _logger.i('signUp');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;

      await _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'uid': user.uid,
      });

      return user;
    } catch (e) {
      _logger.e('signUp', e);
      return null;
    }
  }

  @override
  Future<void> updateUserData(
      String name, String email, String photoUrl, String uid) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
