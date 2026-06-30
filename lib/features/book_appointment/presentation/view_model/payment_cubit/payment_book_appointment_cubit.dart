import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/helper_function/get_it_service.dart';
import '../../../../payment/data/models/payment_response_model.dart';
import '../../../../payment/data/repos/payment_repo_impl.dart';

part 'payment_book_appointment_state.dart';

class PaymentBookAppointmentCubit extends Cubit<PaymentBookAppointmentState> {
  PaymentBookAppointmentCubit() : super(const PaymentBookAppointmentState());

  Future<void> fetchPaymentMethods() async {
    emit(state.copyWith(status: PaymentListStatus.loading));

    final result = await getIt<PaymentRepoImpl>().getMyPaymentsMethods();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PaymentListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          status: PaymentListStatus.success,
          paymentMethods: response.paymentsModel,
          selectedPaymentId:
              response.paymentsModel.isNotEmpty
                  ? response.paymentsModel.first.id
                  : null,
        ),
      ),
    );
  }

  void selectPaymentMethod(int id) {
    emit(state.copyWith(selectedPaymentId: id));
  }
}
