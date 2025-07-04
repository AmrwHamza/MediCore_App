import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'priviews_state.dart';

class PriviewsCubit extends Cubit<PriviewsState> {
  PriviewsCubit() : super(PriviewsInitial());
}
