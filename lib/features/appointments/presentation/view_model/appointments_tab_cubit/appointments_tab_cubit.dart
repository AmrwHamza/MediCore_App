import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

/// A single request to open the appointments screen on a specific tab.
class AppointmentsTabRequest extends Equatable {
  /// Zero based tab index to open.
  final int index;

  /// Monotonically increasing id that keeps repeated requests distinct so the
  /// cubit never drops a request that targets the same tab.
  final int id;

  const AppointmentsTabRequest({required this.index, required this.id});

  @override
  List<Object> get props => [index, id];
}

/// Drives the selected tab of the appointments screen from outside the screen
/// (e.g. the home "next appointment" card).
class AppointmentsTabCubit extends Cubit<AppointmentsTabRequest?> {
  /// Tab indices of the appointments screen.
  static const int waiting = 0;
  static const int accepted = 1;
  static const int incomplete = 2;

  AppointmentsTabCubit() : super(null);

  int _requestId = 0;

  /// Requests opening the [index] tab.
  void openTab(int index) {
    _requestId++;
    emit(AppointmentsTabRequest(index: index, id: _requestId));
  }
}
