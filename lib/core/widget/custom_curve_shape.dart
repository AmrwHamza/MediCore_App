import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';

class CustomCurvedShape extends StatelessWidget {
  const CustomCurvedShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: KPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(450, 200),
          bottomRight: Radius.elliptical(450, 200),
        ),
      ),
    );
  }
}
