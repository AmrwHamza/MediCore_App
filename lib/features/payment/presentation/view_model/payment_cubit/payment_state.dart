part of 'payment_cubit.dart';

class PaymentState {
  final String? selectedMethod;

  const PaymentState({this.selectedMethod});

  PaymentState copyWith({String? selectedMethod}) {
    return PaymentState(selectedMethod: selectedMethod ?? this.selectedMethod);
  }
}
