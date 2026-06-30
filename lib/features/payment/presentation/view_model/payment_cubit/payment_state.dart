part of 'payment_cubit.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState {
  final String? selectedMethod;
  final String phoneNumber;
  final PaymentStatus status;
  final String? errorMessage;

  const PaymentState({
    this.selectedMethod,
    this.phoneNumber = '',
    this.status = PaymentStatus.initial,
    this.errorMessage,
  });

  PaymentState copyWith({
    String? selectedMethod,
    String? phoneNumber,
    PaymentStatus? status,
    String? errorMessage,
  }) {
    return PaymentState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
