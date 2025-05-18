import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/first_page/view/first_page_auth.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return _fadeRoute(SplashView(), settings);

    case OnBoardingView.routeName:
      return _fadeScaleRoute(OnBoardingView(), settings);

    case FirstPageAuth.routeName:
      return _slideRoute(FirstPageAuth(), settings);

    default:
      return MaterialPageRoute(
        builder:
            (context) =>
                Scaffold(body: Center(child: Text('404 - Page Not Found'))),
      );
  }
}

//Transition Animation

Route _fadeRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: Duration(milliseconds: 1500),
  );
}

Route _slideRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.ease)),
        ),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 1500),
  );
}

Route _fadeScaleRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final curvedAnim = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      return FadeTransition(
        opacity: curvedAnim,
        child: ScaleTransition(scale: curvedAnim, child: child),
      );
    },
    transitionDuration: Duration(milliseconds: 1500),
  );
}
