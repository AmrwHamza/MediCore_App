import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String name,
    required String email,
    required int id,
  }) : super(name: name, email: email, id: id);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }
}
