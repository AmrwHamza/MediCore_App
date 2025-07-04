part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class SendCodeFailure extends OtpState {
  final String error;

  SendCodeFailure({required this.error});
}

final class SendCodeSuccess extends OtpState {
  final String message;

  SendCodeSuccess({required this.message});
}

final class ResendFailure extends OtpState {
  final String error;

  ResendFailure({required this.error});
}

final class ResendSuccess extends OtpState {
  final String code;

  ResendSuccess({required this.code});
}
