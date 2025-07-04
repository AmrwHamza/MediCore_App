import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.isVisible,
    this.color,
  });

  final String title;
  final VoidCallback? onTap;
  bool? isVisible;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Material(
        color: color == null ? KPrimaryColor : color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 50,
            width: 190,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
