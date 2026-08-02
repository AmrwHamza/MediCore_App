import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointment_archive_view.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/accepted_page.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/incomplete_page.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/waiting_page.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';

import '../view_model/cubit/delete_appointment_cubit.dart';
import '../view_model/priviews_cubit/priviews_cubit.dart';

class AppointmentsView extends StatelessWidget {
  static const routeName = '/appointments';

  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<AppointmentsCubit>()..getAppointments(),
        ),
        BlocProvider(create: (context) => PriviewsCubit()..getPriviews()),
        BlocProvider(create: (context) => DeleteAppointmentCubit()),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          floatingActionButton: FloatingActionButton(
            elevation: 4,
            highlightElevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            backgroundColor: KPrimaryColor,
            onPressed: () {
              context.pushNamed(AppointmentArchiveView.routeName);
            },
            child: const Icon(Icons.archive_outlined, color: Colors.white),
          ),
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: 70.h,
            title: Container(
              height: 48.h,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: TabBar(
                labelColor: KPrimaryColor,
                unselectedLabelColor: Colors.grey[500],
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8.r,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                tabs: [
                  Tab(text: 'waiting'.tr()),
                  Tab(text: 'accepted'.tr()),
                  Tab(text: 'incomplete'.tr()),
                ],
              ),
            ),
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              await context.read<AppointmentsCubit>().getAppointments();
              await context.read<PriviewsCubit>().getPriviews();
            },
            child: const TabBarView(
              children: [WaitingPage(), AcceptedPage(), IncompletePage()],
            ),
          ),
        ),
      ),
    );
  }
}
