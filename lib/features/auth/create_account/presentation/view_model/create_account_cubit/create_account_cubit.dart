import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/features/auth/create_account/data/repo/create_account_repo_imp.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  Future<void> createAccount(
    String id, {
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confPassword,
  }) async {
    emit(CreateAccountLoading());
    try {
      final result = await CreateAccountRepoImp().createAccount(
        firstName,
        lastName,
        email,
        phoneNumber,
        password,
        confPassword,
        id,
      );
      return result.fold(
        (failure) {
          emit(CreateAccountFailure(message: failure.message));
          print('${failure.message}=failure message======');
        },
        (data) {
          emit(CreateAccountSuccess(user: data));
          saveUserInfo(
            data.token,
            data.user.email,
            data.user.firstName,
            data.user.lastName,
            data.user.phone,
            data.user.id,
          );
        },
      );
    } on Exception catch (e) {
      emit(CreateAccountFailure(message: e.toString()));
      print('${e.toString()}=failure message==eeee====');
    }
  }
}

Future<void> saveUserInfo(
  String token,
  String firstName,
  String lastName,
  String email,
  String phone,
  int id,
) async {
  await SharedPrefHelper.setData(SharedPrefKeys.userToken, token);
  await SharedPrefHelper.setData(SharedPrefKeys.email, email);
  await SharedPrefHelper.setData(SharedPrefKeys.firstName, firstName);
  await SharedPrefHelper.setData(SharedPrefKeys.lastName, lastName);
  await SharedPrefHelper.setData(SharedPrefKeys.phone, phone);
  await SharedPrefHelper.setData(SharedPrefKeys.id, id);
}
