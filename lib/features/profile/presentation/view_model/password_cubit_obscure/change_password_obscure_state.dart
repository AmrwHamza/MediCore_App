part of 'change_password_obscure_cubit.dart';

sealed class ChangeObscurePasswordState extends Equatable {
  const ChangeObscurePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangeObscurePasswordInitial extends ChangeObscurePasswordState {}

final class ChangeOldPasswordObscure extends ChangeObscurePasswordState {
  final bool obscure;
  const ChangeOldPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeNewPasswordObscure extends ChangeObscurePasswordState {
  final bool obscure;
  const ChangeNewPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeConfirmPasswordObscure extends ChangeObscurePasswordState {
  final bool obscure;
  const ChangeConfirmPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}
