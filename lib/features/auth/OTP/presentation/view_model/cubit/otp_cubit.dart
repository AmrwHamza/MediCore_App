import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  Timer? _timer;

  OTPCubit() : super(OTPState.initial()) {
    _startTimer();
  }

  void updateDigit(int index, String value) {
    final newDigits = List<String>.from(state.digits);
    newDigits[index] = value;
    emit(state.copyWith(digits: newDigits, hasError: false));
  }

  void submit() {
    final code = state.digits.join();
    final isComplete = code.length == 6 && !state.digits.contains('');
    if (isComplete) {
      print("OTP submitted: $code");
      // أضف منطق التحقق هنا
    } else {
      emit(state.copyWith(hasError: true));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    emit(state.copyWith(timerSeconds: 60, isTimerActive: true));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.timerSeconds - 1;
      if (remaining <= 0) {
        timer.cancel();
        emit(state.copyWith(timerSeconds: 0, isTimerActive: false));
      } else {
        emit(state.copyWith(timerSeconds: remaining));
      }
    });
  }

  void resendCode() {
    // أضف منطق إعادة إرسال الرمز هنا
    emit(state.copyWith(digits: List.filled(6, ''), hasError: false));
    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
