part of 'create_account_cubit.dart';

sealed class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

final class CreateAccountInitial extends CreateAccountState {}

final class CreateAccountLoading extends CreateAccountState {}

final class CreateAccountFailure extends CreateAccountState {
  final String message;

  CreateAccountFailure({required this.message});
}

final class CreateAccountSuccess extends CreateAccountState {
  final UserEntity user;
  

  CreateAccountSuccess({required this.user});
}
