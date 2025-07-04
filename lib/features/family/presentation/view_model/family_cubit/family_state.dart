part of 'family_cubit.dart';

sealed class FamilyState extends Equatable {
  const FamilyState();

  @override
  List<Object> get props => [];
}

final class FamilyInitial extends FamilyState {}

final class GetFamilyLoading extends FamilyState {}

final class GetFamilyFailure extends FamilyState {
  final String error;

  const GetFamilyFailure({required this.error});
}

final class GetFamilySuccess extends FamilyState {
  final ChildsEntity children;

  GetFamilySuccess({required this.children});

  @override
  List<Object> get props => [children];
}
