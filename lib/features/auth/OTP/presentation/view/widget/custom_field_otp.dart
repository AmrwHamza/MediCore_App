import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicore_app/constants.dart';

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
        boxShadow: const [
          // BoxShadow(spreadRadius: 5, color: Colors.white, blurRadius: 20)
        ],
        border: Border.all(width: 1.5, color: KDarkBlue),
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
