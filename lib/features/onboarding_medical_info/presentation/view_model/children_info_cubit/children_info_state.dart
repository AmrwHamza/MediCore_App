part of 'children_info_cubit.dart';

sealed class ChildrenInfoState extends Equatable {
  const ChildrenInfoState();

  @override
  List<Object> get props => [];
}

final class ChildrenInfoInitial extends ChildrenInfoState {}

final class AddChildLoading extends ChildrenInfoState {}

final class AddChildSuccess extends ChildrenInfoState {
  final ChildEntity child;

  AddChildSuccess({required this.child});
}

final class ChildFailure extends ChildrenInfoState {
  final String error;

  ChildFailure({required this.error});
}

class DeleteChildLoading extends ChildrenInfoState {}

class DeleteChildSuccess extends ChildrenInfoState {
  final String message;

  DeleteChildSuccess({required this.message});
}
