import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/auth/forget_password/data/repo/forget_password_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final response = await getIt<ForgetPasswordRepo>().forgetPassword(
      email: email,
    );
    response.fold(
      (failure) => emit(ForgetPasswordFailure(error: failure.message)),
      (json) => emit(ForgetPasswordSuccess()),
    );
  }
}
