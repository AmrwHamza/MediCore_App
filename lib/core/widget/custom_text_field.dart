import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController? controller;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    return TextField(
      style: TextStyles.public.copyWith(color: theme.canvasColor),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.black.withAlpha((255 * 0.3).round()),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: KCyan),
        ),
        labelText: labelText,
        labelStyle: TextStyles.public.copyWith(color: Colors.grey),
        floatingLabelStyle: const TextStyle(color: KDarkBlue),
      ),
    );
  }
}
