
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_button.dart';

class AuthSection extends StatelessWidget {
  const AuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(title: 'Greate account', onTap: () {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account ?',
              style: TextStyle(
                color: KWhite,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Login',
                style: TextStyle(
                  color: KCyan,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
