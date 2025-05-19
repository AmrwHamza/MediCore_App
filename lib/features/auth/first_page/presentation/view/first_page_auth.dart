import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/widget/first_page_auth_body.dart';

class FirstPageAuth extends StatelessWidget {
  const FirstPageAuth({super.key});
    static const routeName = '/firstPageAuth';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      
      body: FirstPageAuthBody(),
    );
  }
}