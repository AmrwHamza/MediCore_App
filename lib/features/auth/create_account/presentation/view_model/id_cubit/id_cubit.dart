import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'id_state.dart';

class IdCubit extends Cubit<IdState> {
  IdCubit() : super(IsHasID(isHasID: false));

  void showQeustion({required bool isHasID}) {
    emit(IsHasID(isHasID: isHasID));
  }
}
