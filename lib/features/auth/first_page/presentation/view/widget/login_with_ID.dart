import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/features/auth/login_with_ID/presentation/view/login_with_ID_view.dart';

class LoginWithID extends StatelessWidget {
  const LoginWithID({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, LoginWithIDView.routeName);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 40,
          width: context.locale.languageCode == 'ar' ? 260 : 190,
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
