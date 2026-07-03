import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/payment/presentation/views/widgets/payment_view_body.dart';

import '../../../../core/theme/theme_provider.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../../../auth/public_cubits/auth_validate_cubit/auth_validate_cubit.dart';
import '../view_model/payment_cubit/payment_cubit.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, this.isInSplash = true});

  final bool isInSplash;

  static const routeName = '/payment';

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => AuthValidateCubit()),
      ],
      child: Scaffold(
        backgroundColor:
            context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: 'payment_method'.tr(),
          isMainBar: false,
          color: KPrimaryColor,
        ),
        body: PaymentViewBody(isInSplash: widget.isInSplash),
      ),
    );
  }
}
