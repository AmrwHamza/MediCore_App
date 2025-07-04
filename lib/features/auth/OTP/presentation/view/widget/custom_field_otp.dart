import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomTextFieldOTP extends StatelessWidget {
  const CustomTextFieldOTP({
    required this.first,
    required this.last,
    required this.controller,
    super.key,
  });

  final bool first;
  final bool last;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Provider.of<ThemeProvider>(
              context,
            ).themeData.splashColor.withAlpha((255 * 0.5).round()),
            // spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          width: 1.5,
          color: KDarkBlue.withAlpha((0.5 * 255).round()),
        ),
        borderRadius: BorderRadius.circular(10),
        color: KWhite,
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        style: const TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).width / 8,
            maxWidth: MediaQuery.sizeOf(context).width / 8,
          ),
        ),
      ),
    );
  }
}
