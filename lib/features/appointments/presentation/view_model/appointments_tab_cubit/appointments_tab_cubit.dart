import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class AppointmentsTabRequest extends Equatable {

  final int index;

  final int id;

  const AppointmentsTabRequest({required this.index, required this.id});

  @override
  List<Object> get props => [index, id];
}

class AppointmentsTabCubit extends Cubit<AppointmentsTabRequest?> {

  static const int waiting = 0;
  static const int accepted = 1;
  static const int incomplete = 2;

  AppointmentsTabCubit() : super(null);

  int _requestId = 0;

  void openTab(int index) {
    _requestId++;
    emit(AppointmentsTabRequest(index: index, id: _requestId));
  }
}
