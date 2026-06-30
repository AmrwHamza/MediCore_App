import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/payment/data/models/payment_method_model.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/provider_logo_container.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/selection_indicator.dart';

import '../../../data/models/payment_response_model.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ThemeData theme;
  final bool isSelected;
  final ValueChanged<String> onTap;
  final PaymentModel paymentModel;

  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.isSelected,
    required this.onTap,
    required this.paymentModel,
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
        onTap: () => onTap(paymentModel.paymentType.name),
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
                  assetPath: PaymentMethodModel.getPaymentLogo(
                    paymentModel.paymentType,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: theme.canvasColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xff7C8283),
                            fontSize: 12,
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 4),
                        Text(
                          paymentModel.phoneNumber,
                          style: const TextStyle(
                            color: Color(0xff7C8283),
                            fontSize: 12,
                          ),
                        ),
                      ],
                      if (paymentModel.balance != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'payment_balance'.tr(args: [paymentModel.balance.toString()]),
                          style: const TextStyle(
                            color: Color(0xff7C8283),
                            fontSize: 12,
                          ),
                        ),
                      ],
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
