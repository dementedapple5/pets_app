import 'package:pets_app/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.email, required super.token});

  factory UserModel.fromEntity(User user) {
    return UserModel(email: user.email, token: user.token);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'token': token};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'] as String, token: json['token'] as String);
  }
}
