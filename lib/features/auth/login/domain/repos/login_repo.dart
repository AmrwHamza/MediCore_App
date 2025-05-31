import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginUserEntity>> login({
    required String email,
    required String phoneNumber,
    required String password,
  });
}
