import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/department_cubit/department_book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/symptom_analysis_cubit/symptom_analysis_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/book_appointment_view_body.dart';

import '../../../appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import '../../../family/presentation/view_model/family_cubit/family_cubit.dart';
import '../view_model/payment_cubit/payment_book_appointment_cubit.dart';

class BookAppointmentView extends StatelessWidget {
  static const String routeName = '/book-appointment';

  const BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'book_appointment'.tr(),
        isMainBar: false,
        color: KPrimaryColor,
      ),
      backgroundColor:
          context.watch<ThemeProvider>().themeData.scaffoldBackgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = SymptomAnalysisCubit();
              Future.microtask(() {
                cubit.getSymptoms(lang: context.locale.languageCode);
              });
              return cubit;
            },
          ),
          BlocProvider(create: (context) => BookAppointmentCubit()),
          BlocProvider(create: (context) => DoctorBookAppointmentCubit()),
          BlocProvider(
            create:
                (context) =>
                    DepartmentBookAppointmentCubit()..getDepartments(context),
          ),
          BlocProvider(
            create:
                (context) =>
                    PaymentBookAppointmentCubit()..fetchPaymentMethods(),
          ),
          BlocProvider(create: (context) => FamilyCubit()),
          BlocProvider(create: (context) => AppointmentsCubit())
        ],

        child: const BookAppointmentViewBody(),
      ),
    );
  }
}
