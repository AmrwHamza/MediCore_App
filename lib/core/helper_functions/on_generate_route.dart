import 'package:flutter/material.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());

    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
