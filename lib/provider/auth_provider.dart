import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rainbow_wings/respository/auth_respository.dart';
import 'package:rainbow_wings/respositoryImpl/auth_respository_impl.dart';

// final authRespositoryImpl = AuthRespositoryImpl;
final authRepositoryProvider = Provider(
  (ref) => AuthRespositoryImpl(),
);

final authProvider = ChangeNotifierProvider.autoDispose(
  (ref) => AuthProvider(
    ref.read(
      authRepositoryProvider,
    ),
  ),
);

class AuthProvider extends ChangeNotifier {
  final AuthRespository authRespositoryImpl;

  bool isLoading = false;

  AuthProvider(this.authRespositoryImpl);

  bool isLoggedIn() {
    if (authRespositoryImpl.getCurrentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    authRespositoryImpl.signOut();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      await authRespositoryImpl.login(email, password);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
