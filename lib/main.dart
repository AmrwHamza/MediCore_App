import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/core/helper/observer.dart';
import 'package:medicore_app/core/helper_functions/on_generate_route.dart';
import 'package:medicore_app/features/auth/first_page/view/first_page_auth.dart';
import 'package:medicore_app/features/auth/first_page/view_model/language_cubit/language_cubit.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(const MediCoreApp());
}

class MediCoreApp extends StatelessWidget {
  const MediCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LanguageCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: FirstPageAuth.routeName,
      ),
    );
  }
}
