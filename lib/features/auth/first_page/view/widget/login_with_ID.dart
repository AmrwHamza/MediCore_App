import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';

class LoginWithID extends StatelessWidget {
  const LoginWithID({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 40,
          width: context.locale.languageCode == 'ar' ? 250 : 190,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.credit_card, color: KDarkBlue),
              const SizedBox(width: 16),
              Text('login with ID', style: TextStyles.public).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
