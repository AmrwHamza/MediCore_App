import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';

import '../../../../payment/data/models/payment_method_model.dart';
import '../../../../payment/presentation/views/widgets/payment_method_card.dart';
import '../../view_model/book_cubit/book_appointment_cubit.dart';
import '../../view_model/payment_cubit/payment_book_appointment_cubit.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<
      PaymentBookAppointmentCubit,
      PaymentBookAppointmentState
    >(
      listener: (context, state) {
        if (state.status == PaymentListStatus.success &&
            state.selectedPaymentId != null) {
          context.read<BookAppointmentCubit>().setSelectedPaymentId(
            state.selectedPaymentId,
          );
        }
      },
      builder: (context, state) {
        if (state.status == PaymentListStatus.loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(color: KPrimaryColor),
            ),
          );
        }

        if (state.status == PaymentListStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? 'فشل تحميل طرق الدفع',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state.paymentMethods.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withAlpha(40)),
            ),
            child: Center(child: Text('no_payment'.tr())),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.paymentMethods.length,
          itemBuilder: (context, index) {
            final method = state.paymentMethods[index];
            final paymentType = method.paymentType;
            final isSelected = state.selectedPaymentId == method.id;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: PaymentMethodCard(
                title: PaymentMethodModel.getPaymentTitle(paymentType),
                subtitle: '',
                theme: theme,
                isSelected: isSelected,
                onTap: (_) {
                  context
                      .read<PaymentBookAppointmentCubit>()
                      .selectPaymentMethod(method.id);
                  context.read<BookAppointmentCubit>().setSelectedPaymentId(
                    method.id,
                  );
                },
                paymentModel: method,
              ),
            );
          },
        );
      },
    );
  }
}
