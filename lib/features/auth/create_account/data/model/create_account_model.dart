import 'package:medicore_app/features/auth/create_account/data/model/user_model.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

class CreateAccountModel extends UserEntity {
  CreateAccountModel({
    required String token,
    required UserModel user,
  }) : super(token: token,user: user);

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountModel(
      token: json['access_token'],
      user: json['user'],
    );
  }
}
