import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

abstract class CreateAccountRepo {
  Future<Either<Failure, UserEntity>> createAccount(
     String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confPassword,
    String id,
  );
}
