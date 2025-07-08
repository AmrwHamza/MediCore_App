import 'package:medicore_app/features/auth/create_account/data/model/user_model.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

class CreateAccountModel extends UserEntity {
  CreateAccountModel({
    required String token,
    required UserModel user,
    required String expiresAt,
  }) : super(token: token, user: user, expiresAt: expiresAt);

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountModel(
      token: json['token']['access_token'],
      user: UserModel.fromJson(json['user']),
      expiresAt: json['token']['expires_at'],
    );
  }
}
