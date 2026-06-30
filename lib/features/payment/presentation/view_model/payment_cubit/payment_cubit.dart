import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../data/repos/payment_repo_impl.dart';
import '../../../domain/repos/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo _paymentRepo = getIt<PaymentRepoImpl>();

  PaymentCubit() : super(const PaymentState());

  void selectMethod(String methodId) {
    emit(state.copyWith(selectedMethod: methodId));
  }

  void updatePhoneNumber(String phone) {
    emit(state.copyWith(phoneNumber: phone));
  }

  Future<void> confirmPayment() async {
    if (state.selectedMethod == null || state.phoneNumber.trim().isEmpty)
      return;

    emit(state.copyWith(status: PaymentStatus.loading));

    final result = await _paymentRepo.addPaymentMethods(
      phoneNumber: state.phoneNumber,
      paymentMethod: state.selectedMethod!,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: PaymentStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (paymentModel) {
        emit(state.copyWith(status: PaymentStatus.success));
      },
    );
  }
}
