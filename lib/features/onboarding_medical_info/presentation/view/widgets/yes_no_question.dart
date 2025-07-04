import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class YesNoQuestion extends StatelessWidget {
  final String question;
  final bool showField;
  final Function(bool) onChanged;
  final TextEditingController controller;
  final String hintText;

  const YesNoQuestion({
    required this.question,
    required this.showField,
    required this.onChanged,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;
    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              question,
              style: TextStyles.H2.copyWith(color: theme.canvasColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<bool>(
                  activeColor: KPrimaryColor,
                  value: true,
                  groupValue: showField,
                  onChanged: (_) => onChanged(true),
                ),
                Text(
                  "Yes",
                  style: TextStyles.public.copyWith(color: theme.canvasColor),
                ),
                Radio<bool>(
                  activeColor: KPrimaryColor,
                  value: false,
                  groupValue: showField,
                  onChanged: (_) => onChanged(false),
                ),
                Text(
                  "No",
                  style: TextStyles.public.copyWith(color: theme.canvasColor),
                ),
              ],
            ),
            if (showField)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 8,
                ),
                child: TextField(
                  style: TextStyles.public.copyWith(color: theme.canvasColor),
                  cursorColor: KCyan,
                  maxLines: null,
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: hintText,
                    hintStyle: TextStyles.public.copyWith(color: Colors.grey),
                    filled: true,
                    fillColor: theme.primaryColor,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: KCyan, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.grey.withAlpha((0.8 * 255).round()),
                      ),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.grey.withAlpha((255 * 0.5).round()),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
