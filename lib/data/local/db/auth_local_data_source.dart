import 'package:pets_app/data/local/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  UserModel? _currentUser;

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate API call - always returns true as requested
    // In a real app, this would make an HTTP request
    final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

    _currentUser = UserModel(email: email, token: token);

    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }
}
