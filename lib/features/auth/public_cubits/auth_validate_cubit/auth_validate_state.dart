import 'package:equatable/equatable.dart';

sealed class AuthValidateState extends Equatable {
  const AuthValidateState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthValidateState {}

final class ChangePasswordObscure extends AuthValidateState {
  final bool obscure;
  const ChangePasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeConfirmPasswordObscure extends AuthValidateState {
  final bool obscure;
  const ChangeConfirmPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}
