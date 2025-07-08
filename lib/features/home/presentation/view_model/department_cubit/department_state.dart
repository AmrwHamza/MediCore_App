part of 'department_cubit.dart';

sealed class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object> get props => [];
}

final class DepartmentInitial extends DepartmentState {}

final class DepartmentLoading extends DepartmentState {}

final class DepartmentFailure extends DepartmentState {
  final String error;

  DepartmentFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class DepartmentSuccess extends DepartmentState {
  final List<DepartmentEntity> departments;

  DepartmentSuccess({required this.departments});

  @override
  List<Object> get props => [departments];
}
