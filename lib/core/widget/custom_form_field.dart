import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool obscure;
  final Function()? pressOnEye;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool enabled;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomFormField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.obscure = false,
    this.pressOnEye,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.enabled = true,
    this.hintText,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fillColor = isDark ? KSurfaceDark.withValues(alpha: 0.55) : KWhite;
    final iconColor = enabled ? KPrimaryColor : KDisabledLight;
    final borderColor = isDark ? KBorderDark : KBorderLight;
    final labelColor = isDark ? KTextSecondaryDark : KGrey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyles.notes.copyWith(color: labelColor)),
          const SizedBox(height: 6),
          TextFormField(
            enabled: enabled,
            controller: controller,
            obscureText: obscure,
            onChanged: onChanged,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            validator: validator,
            style: TextStyle(color: isDark ? KTextPrimaryDark : KTextPrimaryLight),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyles.notes.copyWith(color: Colors.grey),
              filled: true,
              fillColor: fillColor,
              prefixIcon: Icon(icon, color: iconColor),
              suffixIcon:
                  isPassword
                      ? IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: iconColor,
                        ),
                        onPressed: pressOnEye,
                      )
                      : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: enabled ? borderColor : borderColor.withValues(alpha: 0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: enabled ? KPrimaryColor : borderColor,
                  width: 1.6,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: borderColor.withValues(alpha: 0.3),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: KError),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: KError),
              ),
              errorStyle: const TextStyle(
                color: KError,
                fontSize: 12,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
