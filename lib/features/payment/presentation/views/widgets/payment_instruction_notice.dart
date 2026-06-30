import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

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
