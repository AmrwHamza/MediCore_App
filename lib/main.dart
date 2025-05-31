import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/observer.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/helper_functions/on_generate_route.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view_model/cubit/otp_cubit.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/create_account.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/create_account_cubit/create_account_cubit.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view_model/id_cubit/id_cubit.dart';
import 'package:medicore_app/features/auth/login/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:medicore_app/features/auth/public_cubits/auth_cubit/auth_cubit.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view_model/change_lang_cubit/change_language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = SharedPrefHelper();
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
  final SharedPrefHelper prefs;
  const MediCoreApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> AuthCubit()),
            BlocProvider(create: (context)=> IdCubit()),
            BlocProvider(create: (context)=> OtpCubit()),
            BlocProvider(create: (context)=> LoginCubit()),
            BlocProvider(create: (context)=> CreateAccountCubit()),
            BlocProvider(create: (context)=> ChangeLanguageCubit(SharedPrefHelper())),
          ],
          child: MaterialApp(
            theme: ThemeData(
              fontFamily:
                  context.locale.languageCode == 'ar'
                      ? 'Tajawal'
                      : 'RobotoSLab',
            ),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: CreateAccount .routeName,
          ),
        );
      },
    );
  }

  Future<bool> checkIfLoggedInUser() async {
  final String? userToken =
      await SharedPrefHelper.getString(SharedPrefKeys.userToken);

  if (userToken != null && userToken.isNotEmpty) {
    print('user token:$userToken');
  } else {}

  return userToken != null && userToken.isNotEmpty;
}

}
