import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_cubit/department_cubit.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctors_cubit/doctors_cubit.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DepartmentCubit()..getDepartments(context),
          ),
          BlocProvider(create: (context) => DoctorsCubit()..getDoctors()),
        ],
        child: const HomeViewBody(),
      ),
    );
  }
}
