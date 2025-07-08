import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changeIndex(int index) {
    if (index == 2) return;
    emit(index);
  }
}
