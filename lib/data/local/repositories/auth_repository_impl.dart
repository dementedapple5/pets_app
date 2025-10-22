import 'package:pets_app/data/local/db/auth_local_data_source.dart';
import 'package:pets_app/domain/entities/user.dart';
import 'package:pets_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _authDataSource;

  AuthRepositoryImpl({required AuthLocalDataSource authDataSource}) : _authDataSource = authDataSource;

  @override
  Future<User> login(String email, String password) async {
    final userModel = await _authDataSource.login(email, password);
    return userModel;
  }

  @override
  Future<void> logout() async {
    await _authDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await _authDataSource.getCurrentUser();
    return userModel;
  }
}
