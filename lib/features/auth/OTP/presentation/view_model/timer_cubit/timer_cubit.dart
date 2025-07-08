import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  Timer? _resendTimer;

  void startResendTimer({int seconds = 60}) {
    int time = seconds;
    emit(TimerUpdated(time));
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time--;
      emit(TimerUpdated(time));
      if (time <= 0) timer.cancel();
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
