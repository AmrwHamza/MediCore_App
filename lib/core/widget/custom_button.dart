import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isVisible,
  });

  final String title;
  final VoidCallback onTap;
  bool? isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: KPrimaryColor,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoSlab',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
