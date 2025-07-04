import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/features/auth/OTP/data/repo/otp_repo_impl.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepoImpl otpRepo;

  OtpCubit(this.otpRepo) : super(OtpInitial());

  Future<void> sendCode({required String code}) async {
    emit(OtpLoading());
    final result = await getIt<OtpRepoImpl>().sendCode(code);
    result.fold(
      (failure) => emit(SendCodeFailure(error: failure.message)),
      (data) => emit(SendCodeSuccess(message: data.message)),
    );
  }

  Future<void> resendCode() async {
    emit(OtpLoading());
    final result = await getIt<OtpRepoImpl>().resendCode();
    result.fold((failure) => emit(ResendFailure(error: failure.message)), (
      data,
    ) {
      emit(ResendSuccess(code: data.message));
    });
  }
}
