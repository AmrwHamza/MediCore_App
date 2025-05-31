import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/auth/create_account/data/model/create_account_model.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';
import 'package:medicore_app/features/auth/create_account/domain/repos/create_account_repo.dart';

class CreateAccountRepoImp extends CreateAccountRepo {
  @override
  Future<Either<Failure, UserEntity>> createAccount(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String confPassword,
    String id,
  ) async {
    final response = await Api().post(
      endPoint: 'auth/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'password_confirmation': confPassword,
        // "enter_id": id,
      },
     
    );
    return response.fold((failure) => Left(failure), (data) {
      final user = CreateAccountModel.fromJson(data);
      return Right(user);
    });
  }
}
