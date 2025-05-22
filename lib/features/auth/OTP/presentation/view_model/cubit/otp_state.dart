class OTPState {
  final List<String> digits;
  final bool hasError;
  final int timerSeconds;
  final bool isTimerActive;

  const OTPState({
    required this.digits,
    required this.hasError,
    required this.timerSeconds,
    required this.isTimerActive,
  });

  factory OTPState.initial() {
    return const OTPState(
      digits: ['', '', '', '', '', ''],
      hasError: false,
      timerSeconds: 60,
      isTimerActive: true,
    );
  }

  OTPState copyWith({
    List<String>? digits,
    bool? hasError,
    int? timerSeconds,
    bool? isTimerActive,
  }) {
    return OTPState(
      digits: digits ?? this.digits,
      hasError: hasError ?? this.hasError,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isTimerActive: isTimerActive ?? this.isTimerActive,
    );
  }
}
