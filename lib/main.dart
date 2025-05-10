import 'package:flutter/material.dart';
import 'package:medicore_app/core/helper_functions/on_generate_route.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MediCoreApp());
}

class MediCoreApp extends StatelessWidget {
  const MediCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
initialRoute:SplashView.routeName ,
    );
  }
}
