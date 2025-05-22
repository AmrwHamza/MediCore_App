import 'package:flutter/material.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/create_account.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/auth/login/presentation/view/login_view.dart';
import 'package:medicore_app/features/auth/login_with_ID/presentation/view/login_with_ID_view.dart';
import 'package:medicore_app/features/home/presentation/view/home_view.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';
import 'package:animations/animations.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return _fadeRoute(SplashView(), settings);

    case OnBoardingView.routeName:
      return _sharedAxisTransition(OnBoardingView(), settings);

    case FirstPageAuth.routeName:
      return _fadeThroughTransition(FirstPageAuth(), settings);

    case CreateAccount.routeName:
      return _slideRoute(CreateAccount(), settings);

    case LoginView.routeName:
      return _slideRoute(LoginView(), settings);

    case LoginWithIDView.routeName:
      return _slideRoute(LoginWithIDView(), settings);
    case OTPView.routeName:
      return _fadeThroughTransition(OTPView(), settings);
    case HomeView.routeName:
      return _springSlideTransition(HomeView(), settings);

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
    transitionDuration: Duration(milliseconds: 500),
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
    transitionDuration: Duration(milliseconds: 500),
  );
}

Route _fadeThroughTransition(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
  );
}

Route _sharedAxisTransition(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
  );
}

Route _springSlideTransition(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final spring = CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(spring),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 800),
  );
}
