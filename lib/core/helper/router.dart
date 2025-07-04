import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointment_archive_view.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointment_details_view.dart';
import 'package:medicore_app/features/appointments/presentation/view/appointments_view.dart';
import 'package:medicore_app/features/articles/presentation/view/articles_view.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_view.dart';
import 'package:medicore_app/features/auth/OTP/presentation/view/otp_view.dart';
import 'package:medicore_app/features/auth/create_account/presentation/view/create_account.dart';
import 'package:medicore_app/features/auth/first_page/presentation/view/first_page_auth.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/forget_password_view.dart';
import 'package:medicore_app/features/auth/forget_password/presentation/view/back_page_view.dart';
import 'package:medicore_app/features/auth/login/presentation/view/login_view.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/book_appointment_view.dart';
import 'package:medicore_app/features/family/presentation/view/child_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/department_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/home_view.dart';
import 'package:medicore_app/features/main_home/presentation/view/main_home_view.dart';
import 'package:medicore_app/features/notification/presentation/view/notification_view.dart';
import 'package:medicore_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/children_info_view.dart';
import 'package:medicore_app/features/onboarding_medical_info/presentation/view/patient_info_view.dart';
import 'package:medicore_app/features/profile/presentation/view/change_password_view.dart';
import 'package:medicore_app/features/profile/presentation/view/edit_profile_view.dart';
import 'package:medicore_app/features/profile/presentation/view/profile_view.dart';
import 'package:medicore_app/features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routeName,
  errorBuilder:
      (context, state) =>
          const Scaffold(body: Center(child: Text('404 - Page Not Found'))),
  routes: [
    GoRoute(
      path: SplashView.routeName,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: OnBoardingView.routeName,
      builder: (context, state) => const OnBoardingView(),
    ),
    GoRoute(
      path: FirstPageAuth.routeName,
      name: FirstPageAuth.routeName,
      builder: (context, state) => const FirstPageAuth(),
    ),
    GoRoute(
      path: CreateAccount.routeName,
      name: CreateAccount.routeName,
      builder: (context, state) => const CreateAccount(),
    ),
    GoRoute(
      path: LoginView.routeName,
      name: LoginView.routeName,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: OTPView.routeName,
      name: OTPView.routeName,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return OTPView(isForgetPassword: args?['isForgetPassword'] ?? false);
      },
    ),

    GoRoute(
      path: PatientInfoView.routeName,
      name: PatientInfoView.routeName,
      builder: (context, state) => const PatientInfoView(),
    ),
    GoRoute(
      path: ChildrenInfoView.routeName,
      name: ChildrenInfoView.routeName,
      builder: (context, state) => ChildrenInfoView(),
    ),
    GoRoute(
      path: HomeView.routeName,
      name: HomeView.routeName,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: MainHomeView.routeName,
      name: MainHomeView.routeName,
      builder: (context, state) => MainHomeView(),
    ),
    GoRoute(
      path: ArticlesView.routeName,
      name: ArticlesView.routeName,
      builder: (context, state) => const ArticlesView(),
    ),
    GoRoute(
      path: AppointmentsView.routeName,
      name: AppointmentsView.routeName,
      builder: (context, state) => const AppointmentsView(),
    ),
    GoRoute(
      path: NotificationView.routeName,
      name: NotificationView.routeName,
      builder: (context, state) => const NotificationView(),
    ),
    GoRoute(
      path: ProfileView.routeName,
      name: ProfileView.routeName,
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: EditProfileView.routeName,
      name: EditProfileView.routeName,
      builder: (context, state) => EditProfileView(),
    ),
    GoRoute(
      path: ChangePasswordView.routeName,
      name: ChangePasswordView.routeName,
      builder: (context, state) => ChangePasswordView(),
    ),
    GoRoute(
      path: AppointmentDetailsView.routeName,
      name: AppointmentDetailsView.routeName,
      builder: (context, state) => const AppointmentDetailsView(),
    ),

    GoRoute(
      path: DepartmentDetailsView.routeName,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return DepartmentDetailsView(
          department: args?['department'] ?? '',
          departmentId: args?['departmentId'] ?? '',
        );
      },
    ),

    GoRoute(
      path: ChildDetailsView.routeName,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return ChildDetailsView(child: args?['child']);
      },
    ),

    GoRoute(
      path: DoctorDetailsView.routeName,
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return _slideTransition(
          child: DoctorDetailsView(doctor: args['doctor']),
        );
      },
    ),
    GoRoute(
      path: ForgetPasswordView.routeName,
      name: ForgetPasswordView.routeName,
      builder: (context, state) => const ForgetPasswordView(),
    ),
    GoRoute(
      path: BookAppointmentView.routeName,
      name: BookAppointmentView.routeName,
      builder: (context, state) => const BookAppointmentView(),
    ),
    GoRoute(
      path: BackPageView.routeName,
      name: BackPageView.routeName,
      builder: (context, state) => const BackPageView(),
    ),
    GoRoute(
      path: AppointmentArchiveView.routeName,
      name: AppointmentArchiveView.routeName,
      builder: (context, state) => const AppointmentArchiveView(),
    ),

    GoRoute(
      path: ArticleDetailsView.routeName,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return ArticleDetailsView(article: args?['article']);
      },
    ),
  ],
);

// ========== TRANSITION HELPERS ==========

CustomTransitionPage _slideTransition({required Widget child}) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder:
        (context, animation, _, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}
