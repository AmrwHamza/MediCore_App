import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/core/helper/observer.dart';
import 'package:medicore_app/core/helper/router.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_cubit/patient_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';
import 'package:provider/provider.dart';

import 'features/appointments/presentation/view_model/appointments_cubit/appointments_cubit.dart';
import 'features/drawer/presentation/view_model/cubit/profile_image_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = SharedPrefHelper();
  await prefs.init();

  await EasyLocalization.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.init();

  Bloc.observer = const CounterObserver();

  runApp(
  EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: Locale(prefs.languageCode),
    child: ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MediCoreApp(prefs: prefs),
      ),
    ),
  ),
);
}

class MediCoreApp extends StatelessWidget {
  final SharedPrefHelper prefs;
  const MediCoreApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PatientInfoCubit()),
        BlocProvider(create: (context) => ChildrenInfoUiCubit()),
        BlocProvider(create: (context) => getIt<PatientInfoUiCubit>()),
        BlocProvider(create: (context) => ChildrenInfoCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => AppointmentsCubit()),
        BlocProvider(
      create: (_) => ProfileImageCubit()..getProfileImage(),
    ),
      ],
      child: Builder(
        builder: (context) {
          final theme = context.watch<ThemeProvider>().themeData;
          return MaterialApp.router(
            themeMode: ThemeMode.system,
            theme: theme.copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                fontFamily:
                    context.locale.languageCode == 'ar'
                        ? 'Tajawal'
                        : 'RobotoSlab',
              ),
            ),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
