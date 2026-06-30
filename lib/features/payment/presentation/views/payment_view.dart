import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../onboarding_medical_info/presentation/view/patient_info_view.dart';
import '../../data/models/payment_method_model.dart';
import '../view_model/payment_cubit/payment_cubit.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  static const routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(20.0),
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
                        ...PaymentMethodModel.providers.map((provider) {
                          final isSyriatel = provider.value == 'syriatel';
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: PaymentMethodCard(
                              model: provider,
                              subtitle:
                                  isSyriatel
                                      ? 'syriatel_cash_desc'.tr()
                                      : 'cash_mtn_desc'.tr(),
                              assetPath:
                                  isSyriatel
                                      ? Assets.syriatelLogo
                                      : Assets.mtnLogo,
                              theme: theme,
                              isSelected:
                                  state.selectedMethod == provider.value,
                              onTap:
                                  (value) => context
                                      .read<PaymentCubit>()
                                      .selectMethod(value),
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        const PaymentInstructionNotice(),
                      ]),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            title: 'confirm_payment'.tr(),
                            isVisible: true,
                            color:
                                state.selectedMethod != null
                                    ? KPrimaryColor
                                    : (isDark
                                        ? Colors.white10
                                        : Colors.black12),
                            onTap:
                                state.selectedMethod != null
                                    ? () {
                                      context
                                          .read<PaymentCubit>()
                                          .confirmPayment();
                                      context.goNamed(
                                        PatientInfoView.routeName,
                                      );
                                    }
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PaymentHeaderSection extends StatelessWidget {
  const PaymentHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [const Color(0xFF2A3647), const Color(0xFF273142)]
                  : [KPrimaryColor.withAlpha(30), const Color(0xffE7F9FE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: KPrimaryColor.withAlpha(50), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: KPrimaryColor.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: KPrimaryColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'secure_checkout'.tr(),
                  style: TextStyle(
                    color: theme.canvasColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'checkout_encrypted_desc'.tr(),
                  style: const TextStyle(
                    color: Color(0xff7C8283),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodModel model;
  final String subtitle;
  final String assetPath;
  final ThemeData theme;
  final bool isSelected;
  final ValueChanged<String> onTap;

  const PaymentMethodCard({
    super.key,
    required this.model,
    required this.subtitle,
    required this.assetPath,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      child: Material(
        color:
            isSelected
                ? (isDark ? KCardDark : const Color(0xffE7F9FE))
                : theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => onTap(model.value),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    isSelected
                        ? KPrimaryColor
                        : theme.shadowColor.withAlpha(20),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withAlpha(isDark ? 10 : 25),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                ProviderLogoContainer(
                  isDark: isDark,
                  isSelected: isSelected,
                  assetPath: assetPath,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(
                          color: theme.canvasColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xff7C8283),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SelectionIndicator(isSelected: isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProviderLogoContainer extends StatelessWidget {
  final bool isDark;
  final bool isSelected;
  final String assetPath;

  const ProviderLogoContainer({
    super.key,
    required this.isDark,
    required this.isSelected,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color:
            isSelected
                ? (isDark ? KBackgroundDark : Colors.white)
                : (isDark ? KBackgroundDark : const Color(0xffE7F9FE)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? KPrimaryColor.withAlpha(80) : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}

class SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const SelectionIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? KPrimaryColor : const Color(0xff7C8283),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child:
            isSelected
                ? const CircleAvatar(radius: 6, backgroundColor: KPrimaryColor)
                : const SizedBox(width: 12, height: 12),
      ),
    );
  }
}

class PaymentInstructionNotice extends StatelessWidget {
  const PaymentInstructionNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KOrange.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: KOrange.withAlpha(40), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(Icons.info_outline_rounded, color: KOrange, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'payment_notice_text'.tr(),
              style: const TextStyle(
                color: KDarkBlue,
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
