import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isAuthenticated = false.obs;
  // final _user = Rxn<User>();

  bool get isAuthenticated => _isAuthenticated.value;
  // User? get user => _user.value;

  Future<void> login(String username, String password) async {
    // Implement login logic here
    // Example:
    // final user = await _authService.login(username, password);
    // _user.value = user;
    _isAuthenticated.value = true;
  }

  Future<void> logout() async {
    // Implement logout logic here
    // Example:
    // await _authService.logout();
    // _user.value = null;
    _isAuthenticated.value = false;
  }

  Future<void> checkAuthStatus() async {
    // Implement logic to check auth status on app start
    // Example:
    // final user = await _authService.getCurrentUser();
    // if (user != null) {
    //   _user.value = user;
    //   _isAuthenticated.value = true;
    // }
  }
}
