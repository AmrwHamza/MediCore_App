import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/departments/presentation/views/widgets/departments_view_body.dart';

import '../view_model/cubit/departments_view_cubit.dart';

class DepartmentsView extends StatelessWidget {
  const DepartmentsView({super.key});

  static const routeName = '/departments_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DepartmentsViewCubit()..getDepartments(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'departments'.tr(), isMainBar: false),
        body: const DepartmentsViewBody(),
      ),
    );
  }
}
