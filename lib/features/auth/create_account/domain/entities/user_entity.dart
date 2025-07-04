import 'package:medicore_app/features/auth/create_account/data/model/user_model.dart';

class UserEntity {
  final String token;
  final UserModel user;
  final String expiresAt;

  UserEntity({
    required this.token,
    required this.user,
    required this.expiresAt,
  });
}
