import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/login_with_ID/presentation/view/widget/login_with_ID_view_body.dart';

class LoginWithIDView extends StatelessWidget {
  const LoginWithIDView({super.key});
  static const routeName = '/loginWithID';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWithIDViewBody(),
    );
  }
}
