import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class CustomPhoneField extends StatelessWidget {
  final String label;
  final void Function(String fullNumber) onChanged;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyles.notes),
          const SizedBox(height: 6),
          IntlPhoneField(
            initialCountryCode: 'SY',
            decoration: InputDecoration(
              filled: true,
              fillColor: KWhite,
              labelStyle: const TextStyle(color: KGrey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: KDarkBlue.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: KDarkBlue.withOpacity(0.5),
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                height: 1.2,
              ),
            ),
            onChanged: (phone) => onChanged(phone.completeNumber),
            validator: (phone) {
              final number = phone?.number ?? '';
              return validator?.call(number);
            },
          ),
        ],
      ),
    );
  }
}
