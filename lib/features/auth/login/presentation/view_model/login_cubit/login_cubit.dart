import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/features/auth/login/data/repo/login_repo_impl.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    final data = {'email': email, 'password': password, 'fcm_token': token};

    final result = await LoginRepoImpl().login(data: data);
    result.fold((failure) => emit(LoginFailure(message: failure.message)), (
      data,
    ) {
      saveUserInfo(
        data.token,
        data.user.firstName,
        data.user.lastName,
        data.user.email,
        data.user.phone,
        data.user.id,
        data.expiresAt,
      );
      emit(LoginSuccess(loginUserEntity: data));
    });
  }
}

Future<void> saveUserInfo(
  String token,
  String firstName,
  String lastName,
  String email,
  String phone,
  int id,
  String expiresAt,
) async {
  await SharedPrefHelper.setData(SharedPrefKeys.userToken, token);
  await SharedPrefHelper.setData(SharedPrefKeys.email, email);
  await SharedPrefHelper.setData(SharedPrefKeys.firstName, firstName);
  await SharedPrefHelper.setData(SharedPrefKeys.lastName, lastName);
  await SharedPrefHelper.setData(SharedPrefKeys.phone, phone);
  await SharedPrefHelper.setData(SharedPrefKeys.id, id);
  await SharedPrefHelper.setData(SharedPrefKeys.expireToken, expiresAt);
}
