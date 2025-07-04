import 'package:medicore_app/features/auth/create_account/data/model/user_model.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';

class LoginModel extends LoginUserEntity {
  LoginModel({required super.token, required super.user, required super.expiresAt});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token']['access_token'],
      user: UserModel.fromJson( json['user'],),
      expiresAt: json['token']['expires_at'],
    );
  }
}
