part of 'payment_book_appointment_cubit.dart';

enum PaymentListStatus { initial, loading, success, failure }

class PaymentBookAppointmentState extends Equatable {
  final PaymentListStatus status;
  final List<PaymentModel> paymentMethods;
  final int? selectedPaymentId;
  final String? errorMessage;

  const PaymentBookAppointmentState({
    this.status = PaymentListStatus.initial,
    this.paymentMethods = const [],
    this.selectedPaymentId,
    this.errorMessage,
  });

  PaymentBookAppointmentState copyWith({
    PaymentListStatus? status,
    List<PaymentModel>? paymentMethods,
    int? selectedPaymentId,
    String? errorMessage,
  }) {
    return PaymentBookAppointmentState(
      status: status ?? this.status,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      selectedPaymentId: selectedPaymentId ?? this.selectedPaymentId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    paymentMethods,
    selectedPaymentId,
    errorMessage,
  ];
}
