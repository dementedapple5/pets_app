import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;

  const LoginState({this.isLoading = false, this.errorMessage, this.isLoggedIn = false});

  copyWith({bool? isLoading, String? errorMessage, bool? isLoggedIn}) => LoginState(
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
  );

  @override
  List<Object?> get props => [isLoading, errorMessage, isLoggedIn];
}
