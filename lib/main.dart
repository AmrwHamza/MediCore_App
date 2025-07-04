import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/observer.dart';
import 'package:medicore_app/core/helper/router.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/helper_function/hive_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/features/auth/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_cubit/children_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/children_info_ui_cubit/children_info_ui_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_cubit/patient_info_cubit.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view_model/patient_info_ui_cubit/patient_info_ui_cubit.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {   
  await initHive();
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = SharedPrefHelper();
  await prefs.init();
  final themeProvider = ThemeProvider();
  await themeProvider.init();
  Bloc.observer = const CounterObserver();
  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(prefs.languageCode),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: MediCoreApp(prefs: prefs),
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

      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            themeMode: ThemeMode.system,
            theme: getIt<ThemeProvider>().themeData.copyWith(
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
