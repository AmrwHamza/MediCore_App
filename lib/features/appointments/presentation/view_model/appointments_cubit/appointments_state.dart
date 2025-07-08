part of 'appointments_cubit.dart';

sealed class AppointmentsState extends Equatable {
  const AppointmentsState();

  @override
  List<Object> get props => [];
}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsSuccess extends AppointmentsState {
  final List<PatientAppointmentEntity> acceptedPatient;
  final List<PatientAppointmentEntity> waitingPatient;
  final List<List<PatientAppointmentEntity>> acceptedSon;
  final List<List<PatientAppointmentEntity>> waitingSon;

  const AppointmentsSuccess({
    required this.acceptedPatient,
    required this.waitingPatient,
    required this.acceptedSon,
    required this.waitingSon,
  });

  @override
  List<Object> get props => [
    acceptedPatient,
    waitingPatient,
    acceptedSon,
    waitingSon,
  ];
}

final class AppointmentsFailure extends AppointmentsState {
  final String error;

  AppointmentsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
