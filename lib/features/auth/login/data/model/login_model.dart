import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';

class LoginModel extends LoginUserEntity {
  LoginModel({required super.id, required super.name, required super.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(name: json['name'], email: json['email'], id: json['id']);
  }
}
