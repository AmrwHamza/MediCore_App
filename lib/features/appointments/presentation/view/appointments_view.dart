import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointment_archive_view.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/accepted_page.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/incomplete_page.dart';
import 'package:medicore_app/features/appointments/presentation/view/widgets/waiting_page.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import 'package:provider/provider.dart';

class AppointmentsView extends StatelessWidget {
  static const routeName = '/appointments';
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: KOrange,
          child: const Icon(Icons.archive, color: Colors.white),
          onPressed: () {
            context.pushNamed(AppointmentArchiveView.routeName);
          },
        ),
        backgroundColor:
            Provider.of<ThemeProvider>(
              context,
            ).themeData.scaffoldBackgroundColor,
        appBar: TabBar(
          labelColor: KPrimaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: KPrimaryColor,
          tabs: [
            Tab(text: 'waiting'.tr()),
            Tab(text: 'accepted'.tr()),
            Tab(text: 'incomplete'.tr()),
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AppointmentsCubit()
              ..getAppointments(),
            ),
          ],
          child: const TabBarView(
            children: [WaitingPage(), AcceptedPage(), IncompletePage()],
          ),
        ),
      ),
    );
  }
}
