import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/domain/repositories/auth_repository.dart';
import 'package:pets_app/presentation/blocs/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository}) : _authRepository = authRepository, super(const LoginState());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Email and password are required'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await _authRepository.login(email, password);
      emit(state.copyWith(isLoading: false, isLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Login failed. Please try again.'));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
