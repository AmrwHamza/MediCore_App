import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class ChangePasswordObscure extends AuthState {
  final bool obscure;
  const ChangePasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}

final class ChangeConfirmPasswordObscure extends AuthState {
  final bool obscure;
  const ChangeConfirmPasswordObscure(this.obscure);

  @override
  List<Object> get props => [obscure];
}
