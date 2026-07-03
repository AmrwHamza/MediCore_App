import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/doctors_view_body.dart';

import '../view_model/cubit/doctors_view_cubit.dart';

class DoctorsView extends StatelessWidget {
  const DoctorsView({super.key});

  static const routeName = '/doctors-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorsViewCubit()..getDoctors(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'doctors'.tr(), isMainBar: false),
        body: const DoctorsViewBody(),
      ),
    );
  }
}
