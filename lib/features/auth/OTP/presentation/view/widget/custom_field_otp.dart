import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../constants.dart';

class CustomTextFieldOTP extends StatefulWidget {
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
  State<CustomTextFieldOTP> createState() => _CustomTextFieldOTPState();
}

class _CustomTextFieldOTPState extends State<CustomTextFieldOTP> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? KPrimaryColor : KPrimaryDark;
    final cardColor =
        isDark ? const Color(0xff0D1117) : const Color(0xffF8FAFC);
    final textPrimary =
        isDark ? const Color(0xffF9FAFB) : const Color(0xff111827);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 56,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 2,
          color:
              _isFocused
                  ? primaryColor
                  : (widget.controller.text.isNotEmpty
                      ? primaryColor.withValues(alpha: 0.5)
                      : (isDark
                          ? const Color(0xff30363D)
                          : const Color(0xffE2E8F0))),
        ),
        boxShadow:
            _isFocused
                ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [],
      ),
      child: Center(
        child: TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          onChanged: (value) {
            setState(() {});
            if (value.isNotEmpty && widget.last == false) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && widget.first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
