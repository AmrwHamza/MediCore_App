part of 'id_cubit.dart';

sealed class IdState extends Equatable {
  const IdState();

  @override
  List<Object> get props => [];
}

final class IsHasID extends IdState {
  final bool isHasID;

  IsHasID({required this.isHasID});
  List<Object> get props => [isHasID];
}
