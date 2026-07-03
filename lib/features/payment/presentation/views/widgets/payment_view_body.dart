import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../../auth/create_account/presentation/view/widget/custom_phone_field.dart';
import '../../../../auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import '../../../../auth/public_cubits/auth_validate_cubit/auth_validate_state.dart';
import '../../../../onboarding_medical_info/presentation/view/patient_info_view.dart';
import '../../../data/models/payment_method_model.dart';
import '../../../data/models/payment_response_model.dart';
import '../../view_model/payment_cubit/payment_cubit.dart';
import 'payment_header_section.dart';
import 'payment_instruction_notice.dart';
import 'payment_method_card.dart';

class PaymentViewBody extends StatefulWidget {
  const PaymentViewBody({super.key, required this.isInSplash});

  final bool isInSplash;

  @override
  State<PaymentViewBody> createState() => _PaymentViewBodyState();
}

class _PaymentViewBodyState extends State<PaymentViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String? phoneNumber;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = size.width > 600;
    final authCubit = context.read<AuthValidateCubit>();

    return SafeArea(
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.status == PaymentStatus.success) {
            widget.isInSplash
                ? context.goNamed(PatientInfoView.routeName)
                : CustomSnackbar.show(
                  context,
                  message: 'add_payment_method_success'.tr(),
                  type: SnackbarType.success,
                );
            widget.isInSplash ? null : context.pop();
          } else if (state.status == PaymentStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'error'.tr()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (blocContext, state) {
          final paymentState = state;
          return Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? size.width * 0.15 : 20.0,
                    vertical: 20.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const PaymentHeaderSection(),
                      const SizedBox(height: 24),
                      Text(
                        'choose_provider'.tr(),
                        style: TextStyle(
                          color: theme.canvasColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'provider_subtitle'.tr(),
                        style: const TextStyle(
                          color: Color(0xff7C8283),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      isTablet
                          ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  mainAxisExtent: 110,
                                ),
                            itemCount: PaymentMethodModel.providers.length,
                            itemBuilder: (context, index) {
                              final provider =
                                  PaymentMethodModel.providers[index];
                              return _buildPaymentCard(
                                blocContext,
                                provider,
                                state,
                                theme,
                              );
                            },
                          )
                          : Column(
                            children:
                                PaymentMethodModel.providers.map((provider) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 16.0,
                                    ),
                                    child: _buildPaymentCard(
                                      blocContext,
                                      provider,
                                      state,
                                      theme,
                                    ),
                                  );
                                }).toList(),
                          ),
                      const SizedBox(height: 8),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child:
                            state.selectedMethod != null
                                ? Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'phone_number'.tr(),
                                        style: TextStyle(
                                          color: theme.canvasColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      CustomPhoneField(
                                        label: 'phone_hint'.tr(),
                                        onChanged: (val) {
                                          setState(() {
                                            phoneNumber = val.trim();
                                            authCubit.phone = val;
                                          });
                                        },
                                        validator: authCubit.validatePhone,
                                      ),
                                    ],
                                  ),
                                )
                                : const SizedBox.shrink(),
                      ),
                      const PaymentInstructionNotice(),
                    ]),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? size.width * 0.15 : 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        state.status == PaymentStatus.loading
                            ? const CircularProgressIndicator(
                              color: KPrimaryColor,
                            )
                            : BlocBuilder<AuthValidateCubit, AuthValidateState>(
                              builder: (context, state) {
                                final isButtonEnabled =
                                    paymentState.selectedMethod != null &&
                                    phoneNumber != null &&
                                    phoneNumber!.isNotEmpty;

                                return CustomButton(
                                  title: 'confirm_payment'.tr(),
                                  isVisible: true,
                                  color:
                                      isButtonEnabled
                                          ? KPrimaryColor
                                          : (isDark
                                              ? Colors.white10
                                              : Colors.black12),
                                  onTap:
                                      isButtonEnabled
                                          ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              blocContext
                                                  .read<PaymentCubit>()
                                                  .confirmPayment(
                                                    phoneNumber: phoneNumber!,
                                                  );
                                            }
                                          }
                                          : null,
                                );
                              },
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext validContext,
    PaymentMethodModel provider,
    PaymentState state,
    ThemeData theme,
  ) {
    return PaymentMethodCard(
      title: provider.title,
      subtitle: PaymentMethodModel.getPaymentDesc(provider.paymentType),
      theme: theme,
      isSelected: state.selectedMethod == provider.value,
      onTap: (value) => validContext.read<PaymentCubit>().selectMethod(value),
      paymentModel: PaymentModel(
        id: provider.id,
        userId: 0,
        phoneNumber: '',
        companyName: provider.value,
        balance: null,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        paymentType: provider.paymentType,
      ),
    );
  }
}
