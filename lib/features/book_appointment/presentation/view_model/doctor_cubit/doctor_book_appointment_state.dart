part of 'doctor_book_appointment_cubit.dart';

sealed class DoctorBookAppointmentState extends Equatable {
  const DoctorBookAppointmentState();

  @override
  List<Object> get props => [];
}

final class DoctorBookAppointmentInitial extends DoctorBookAppointmentState {}

final class DoctorsLoading extends DoctorBookAppointmentState {}

final class GetDoctorsInDepartmentFailure extends DoctorBookAppointmentState {
  final String error;

  GetDoctorsInDepartmentFailure({required this.error});
}

final class GetDoctorsInDepartmentSuccess extends DoctorBookAppointmentState {
  final List<DoctorEntity> doctors;

  GetDoctorsInDepartmentSuccess({required this.doctors});

  @override
  List<Object> get props => [doctors];
}