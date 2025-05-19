import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/observer.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/helper_functions/on_generate_route.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = SharedPrefsManager();
  await prefs.init();

  Bloc.observer = const CounterObserver();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale(prefs.languageCode),
      child: MediCoreApp(prefs: prefs),
    ),
  );
}

class MediCoreApp extends StatelessWidget {
  final SharedPrefsManager prefs;
  const MediCoreApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangeLanguageCubit>(
          create: (_) => ChangeLanguageCubit(prefs),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: ThemeData(fontFamily: context.locale.languageCode == 'ar' ? 'Tajawal' : 'RobotoSLab'),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: FirstPageAuth.routeName,
          );
        },
      ),
    );
  }
}
