import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointments_view.dart';
import 'package:medicore_app/features/articles/presentation/view/articles_view.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/book_appointment_view.dart';
import 'package:medicore_app/features/drawer/presentation/view/drawer_view.dart';
import 'package:medicore_app/features/family/presentation/view/family_view.dart';
import 'package:medicore_app/features/home/presentation/view/home_view.dart';
import 'package:medicore_app/features/main_home/presentation/view_model/nav_cubit/bottom_nav_cubit.dart';
import 'package:provider/provider.dart';

class MainHomeView extends StatelessWidget {
  static const routeName = '/mainHome';
  MainHomeView({super.key});

  final List<Widget> pages = <Widget>[
    const HomeView(),
    const ArticlesView(),
    const Placeholder(),
    const AppointmentsView(),
    const FamilyView(),
  ];

  final List<String> titles = [
    "Home".tr(),
    "Articles".tr(),
    '',
    "Appointments".tr(),
    "Family".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            backgroundColor:
                Provider.of<ThemeProvider>(
                  context,
                ).themeData.scaffoldBackgroundColor,
            appBar: CustomAppBar(title: titles[selectedIndex], isMainBar: true),
            drawer: selectedIndex == 0 ? const DrawerView() : null,
            body: IndexedStack(index: selectedIndex, children: pages),
            floatingActionButton: SizedBox(
              width: 60,
              height: 60,
              child: FloatingActionButton(
                heroTag: 'add appointment',
                isExtended: true,
                onPressed: () {
                  context.push(BookAppointmentView.routeName);
                },
                child: const Icon(Icons.add, size: 36, color: KPrimaryColor),
                backgroundColor: getIt<ThemeProvider>().themeData.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(
                    color: KPrimaryColor.withAlpha((0.5 * 255).round()),
                    width: 2,
                  ),
                ),
                elevation: 6,
              ),
            ),

            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: const BoxDecoration(gradient: kBottomBarGradient),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: const TextStyle(fontSize: 11),
                    unselectedLabelStyle: const TextStyle(fontSize: 10),
                    elevation: 8,
                    backgroundColor: Colors.transparent,
                    selectedItemColor:
                        Provider.of<ThemeProvider>(
                          context,
                        ).themeData.primaryColor,
                    unselectedItemColor: Colors.grey,
                    currentIndex: selectedIndex,
                    onTap: (index) {
                      context.read<BottomNavCubit>().changeIndex(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home_outlined),
                        label: 'Home'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.article_sharp),
                        label: 'Articles'.tr(),
                      ),
                      const BottomNavigationBarItem(
                        icon: SizedBox(width: 0, height: 0),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.event),
                        label: 'Appointments'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.family_restroom_outlined),
                        label: 'Family'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
