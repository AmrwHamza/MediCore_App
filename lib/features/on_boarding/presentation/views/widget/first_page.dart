import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/utils/app_images.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 1),
        Text(
          'Welcome to MediCore app',
          style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: KPrimaryColor,
          ),
        ),
        Spacer(flex: 4),
        Expanded(flex: 50, child: SvgPicture.asset(Assets.doctors)),
      ],
    );
  }
}
