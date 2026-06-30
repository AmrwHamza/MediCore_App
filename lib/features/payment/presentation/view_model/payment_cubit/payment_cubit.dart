import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  void selectMethod(String methodId) {
    emit(state.copyWith(selectedMethod: methodId));
  }

  void confirmPayment() {
    if (state.selectedMethod == null) return;

    if (state.selectedMethod == 'syriatel') {
    } else if (state.selectedMethod == 'mtn') {}
  }
}
