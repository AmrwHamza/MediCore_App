import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/auth/OTP/data/repo/otp_repo_impl.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Timer? _resendTimer;

  Future<void> sendCode({required int code}) async {
    emit(OtpLoading());
    final result = await OtpRepoImpl().sendCode(code);
    result.fold(
      (failure) => emit(SendCodeFailure(error: failure.message)),
      (data) => emit(SendCodeSuccess(message: data.message)),
    );
  }

  Future<void> resendCode() async {
    emit(OtpLoading());
    final result = await OtpRepoImpl().resendCode();
    result.fold((failure) => emit(ResendFailure(error: failure.message)), (
      data,
    ) {
      emit(ResendSuccess(code: data.code));
      startResendTimer();
    });
  }

  void startResendTimer({int seconds = 60}) {
    int time = seconds;
    emit(TimerUpdated(time));
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      emit(TimerUpdated(time));
      if (time <= 0) {
        timer.cancel();
      }
    });
  }
}
