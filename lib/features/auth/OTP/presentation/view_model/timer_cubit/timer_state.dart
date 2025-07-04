part of 'timer_cubit.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

final class TimerInitial extends TimerState {}

final class TimerUpdated extends TimerState {
  final int secondsLeft;

  const TimerUpdated(this.secondsLeft);

  @override
  List<Object> get props => [secondsLeft];
}
