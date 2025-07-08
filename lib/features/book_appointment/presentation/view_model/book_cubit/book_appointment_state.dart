// book_appointment_state.dart

part of 'book_appointment_cubit.dart';

sealed class BookAppointmentState extends Equatable {
  const BookAppointmentState();

  @override
  List<Object?> get props => [];
}

final class BookAppointmentInitial extends BookAppointmentState {}

final class BookAppointmentLoading extends BookAppointmentState {}

final class BookAppointmentFailure extends BookAppointmentState {
  final String error;

  BookAppointmentFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

final class BookAppointmentSuccess extends BookAppointmentState {
  final String message;

  BookAppointmentSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DateSelected extends BookAppointmentState {
  final DateTime date;
  DateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

class TimeSelected extends BookAppointmentState {
  final TimeOfDay time;
  TimeSelected(this.time);

  @override
  List<Object?> get props => [time];
}

class DepartmentSelected extends BookAppointmentState {
  final int departmentId;
  DepartmentSelected(this.departmentId);

  @override
  List<Object?> get props => [departmentId];
}

class DoctorSelected extends BookAppointmentState {
  final int doctorId;
  DoctorSelected(this.doctorId);

  @override
  List<Object?> get props => [doctorId];
}

class CalendarVisibilityChanged extends BookAppointmentState {
 final bool visible;
 CalendarVisibilityChanged(this.visible);

 @override
 List<Object?> get props => [visible];
}
