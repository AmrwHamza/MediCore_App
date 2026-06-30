import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/payment_header_section.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/payment_instruction_notice.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/payment_method_card.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_snack_bar.dart';
import '../../../onboarding_medical_info/presentation/view/patient_info_view.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/models/payment_response_model.dart';
import '../view_model/payment_cubit/payment_cubit.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, this.isInSplash = true});

  final bool isInSplash;

  static const routeName = '/payment';

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
        backgroundColor:
            context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: 'payment_method'.tr(),
          isMainBar: false,
          color: KPrimaryColor,
        ),
        body: SafeArea(
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
                                    PaymentMethodModel.providers.map((
                                      provider,
                                    ) {
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
                                      padding: const EdgeInsets.only(
                                        bottom: 24.0,
                                      ),
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
                                          TextFormField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                              color: theme.canvasColor,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: '9xxxxxxxx',
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.phone_android_rounded,
                                                color: KPrimaryColor,
                                              ),
                                              filled: true,
                                              fillColor:
                                                  isDark
                                                      ? const Color(0xFF2A3647)
                                                      : Colors.grey.withAlpha(
                                                        20,
                                                      ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide.none,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.withAlpha(
                                                    40,
                                                  ),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: KPrimaryColor,
                                                  width: 1.5,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'field_required'.tr();
                                              }
                                              if (value.trim().length < 10) {
                                                return 'invalid_phone'.tr();
                                              }
                                              return null;
                                            },
                                            onChanged:
                                                (value) => blocContext
                                                    .read<PaymentCubit>()
                                                    .updatePhoneNumber(value),
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
                                : CustomButton(
                                  title: 'confirm_payment'.tr(),
                                  isVisible: true,
                                  color:
                                      state.selectedMethod != null &&
                                              state.phoneNumber
                                                  .trim()
                                                  .isNotEmpty
                                          ? KPrimaryColor
                                          : (isDark
                                              ? Colors.white10
                                              : Colors.black12),
                                  onTap:
                                      state.selectedMethod != null &&
                                              state.phoneNumber
                                                  .trim()
                                                  .isNotEmpty
                                          ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              blocContext
                                                  .read<PaymentCubit>()
                                                  .confirmPayment();
                                            }
                                          }
                                          : null,
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
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext validContext,
    PaymentMethodModel provider,
    PaymentState state,
    ThemeData theme,
  ) {
    print('💯💯💯state.selectedMethod = ${state.selectedMethod}');
    print('💯💯💯provider.value = ${provider.value}');

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
