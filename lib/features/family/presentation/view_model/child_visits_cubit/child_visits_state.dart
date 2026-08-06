import 'package:equatable/equatable.dart';
import 'package:medicore_app/features/appointments/domain/entities/privew_entity.dart';

sealed class ChildVisitsState extends Equatable {
  const ChildVisitsState();

  @override
  List<Object?> get props => [];
}

final class ChildVisitsInitial extends ChildVisitsState {}

final class ChildVisitsLoading extends ChildVisitsState {}

final class ChildVisitsSuccess extends ChildVisitsState {
  final List<PrivewEntity> previews;

  const ChildVisitsSuccess({required this.previews});

  @override
  List<Object?> get props => [previews];
}

final class ChildVisitsFailure extends ChildVisitsState {
  final String error;

  const ChildVisitsFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
