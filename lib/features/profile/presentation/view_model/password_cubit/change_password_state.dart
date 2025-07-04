part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangeOldPasswordObscure extends ChangePasswordState {
  final bool obscure;
  const ChangeOldPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeNewPasswordObscure extends ChangePasswordState {
  final bool obscure;
  const ChangeNewPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeConfirmPasswordObscure extends ChangePasswordState {
  final bool obscure;
  const ChangeConfirmPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}
