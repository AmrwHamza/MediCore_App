import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/widget/create_account_body.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_cubit/auth_cubit.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});
  static const routeName = '/createAccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreateAccountBody(),
    );
  }
}
