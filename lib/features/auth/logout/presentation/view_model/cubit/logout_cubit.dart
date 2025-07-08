import 'package:bloc/bloc.dart';
import 'package:medicore_app/core/utils/logger_helper.dart';
import 'package:medicore_app/features/auth/logout/data/repo/logout_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      final result = await LogoutRepo().logout();
      result.fold((failure) {
        LoggerHelper.success(failure.message);
        emit(LogoutFailure(error: failure.message));
      }, (response) => emit(LogoutSuccess(message: response.message)));
    } on Exception catch (error) {
      emit(LogoutFailure(error: error.toString()));
    }
  }
}
