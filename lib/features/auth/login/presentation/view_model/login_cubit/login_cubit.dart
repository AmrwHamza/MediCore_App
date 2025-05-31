import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/auth/login/data/repo/login_repo_impl.dart';
import 'package:medicore_app/features/auth/login/domain/entities/login_user_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final result = await LoginRepoImpl().login(
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (data) => emit(LoginSuccess(loginUserEntity: data)),
    );
  }


}
