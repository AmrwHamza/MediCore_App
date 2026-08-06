import 'package:equatable/equatable.dart';

sealed class DoctorRateState extends Equatable {
  const DoctorRateState();

  @override
  List<Object?> get props => [];
}

final class DoctorRateInitial extends DoctorRateState {
  const DoctorRateInitial();
}

final class DoctorRateLoading extends DoctorRateState {
  const DoctorRateLoading();
}

final class DoctorRateLoaded extends DoctorRateState {
  final double? userRate;
  final bool hasRated;
  final double? averageRate;
  final bool canRate;
  final bool isSubmitting;
  final String? error;
  final String? successMessage;

  const DoctorRateLoaded({
    this.userRate,
    required this.hasRated,
    this.averageRate,
    required this.canRate,
    this.isSubmitting = false,
    this.error,
    this.successMessage,
  });

  DoctorRateLoaded copyWith({
    double? userRate,
    bool? hasRated,
    double? averageRate,
    bool? canRate,
    bool? isSubmitting,
    String? error,
    String? successMessage,
  }) {
    return DoctorRateLoaded(
      userRate: userRate ?? this.userRate,
      hasRated: hasRated ?? this.hasRated,
      averageRate: averageRate ?? this.averageRate,
      canRate: canRate ?? this.canRate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    userRate,
    hasRated,
    averageRate,
    canRate,
    isSubmitting,
    error,
    successMessage,
  ];
}
