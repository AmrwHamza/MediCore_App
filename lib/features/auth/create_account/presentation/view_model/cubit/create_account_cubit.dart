import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/auth/create_account/data/repo/create_account_repo_imp.dart';
import 'package:medicore_app/features/auth/create_account/domain/entities/user_entity.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  Future<void> createAccount({
    required String email,
    required String phoneNumber,
    required String password,
    required String confPassword,
  }) async {
    final result = await CreateAccountRepoImp().createAccount(
      email,
      phoneNumber,
      password,
      confPassword,
    );
    return result.fold(
      (failure) {
        emit(CreateAccountFailure(message: failure.message));
      },
      (data) {
        emit(CreateAccountSuccess(user: data));
      },
    );
  }
}
