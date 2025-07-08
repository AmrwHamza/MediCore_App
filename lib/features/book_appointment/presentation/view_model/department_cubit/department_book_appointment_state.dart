part of 'department_book_appointment_cubit.dart';

sealed class DepartmentBookAppointmentState extends Equatable {
  const DepartmentBookAppointmentState();

  @override
  List<Object> get props => [];
}

final class DepartmentBookAppointmentInitial extends DepartmentBookAppointmentState{}



final class DepartmentsLoading extends DepartmentBookAppointmentState {}

final class GetDepartmentFailure extends DepartmentBookAppointmentState {
  final String error;

  GetDepartmentFailure({required this.error});
}

final class GetDepartmentsSuccess extends DepartmentBookAppointmentState {
  final List<DepartmentEntity> departments;

  GetDepartmentsSuccess({required this.departments});

  @override
  List<Object> get props => [departments];
}