import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
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
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      LoggerHelper.success('FCM Token:  $token');
      final data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'password_confirmation': confPassword,
        'fcm_token': token,
        "enter_id": id,
      };

      final result = await CreateAccountRepoImp().createAccount(data);
      return result.fold(
        (failure) {
          emit(CreateAccountFailure(message: failure.message));
          print('${failure.message}=failure message======');
        },
        (data) {
          saveUserInfo(
            token: data.token,
            email: data.user.email,
            firstName: data.user.firstName,
            lastName: data.user.lastName,
            phone: data.user.phone,
            id: data.user.id,
            expire: data.expiresAt,
          );
          emit(CreateAccountSuccess(user: data));
        },
      );
    } on Exception catch (e) {
      emit(CreateAccountFailure(message: e.toString()));
      print('${e.toString()}=failure message==eeee====');
    }
  }
}

Future<void> saveUserInfo({
  required String token,
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
  required int id,
  required String expire,
}) async {
  await SharedPrefHelper.setData(SharedPrefKeys.userToken, token);
  await SharedPrefHelper.setData(SharedPrefKeys.email, email);
  await SharedPrefHelper.setData(SharedPrefKeys.firstName, firstName);
  await SharedPrefHelper.setData(SharedPrefKeys.lastName, lastName);
  await SharedPrefHelper.setData(SharedPrefKeys.phone, phone);
  await SharedPrefHelper.setData(SharedPrefKeys.id, id);
  await SharedPrefHelper.setData(SharedPrefKeys.expireToken, expire);
}
