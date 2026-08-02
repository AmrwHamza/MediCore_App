import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/features/home/presentation/view/department_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/department_card.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_home.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/welcome_card.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_cubit/department_cubit.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctors_cubit/doctors_cubit.dart';

import '../../../../../core/theme/theme_provider.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../departments/presentation/views/departments_view.dart';
import '../../../../doctors/presentation/views/doctors_view.dart';
import 'home_error_state.dart';
import 'home_sections_header.dart';
import 'home_skeletons.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final theme = context.watch<ThemeProvider>().themeData;

    return RefreshIndicator.adaptive(
      color: theme.splashColor,
      backgroundColor: theme.cardColor,
      onRefresh: () {
        context.read<DoctorsCubit>().getDoctors();
        context.read<DepartmentCubit>().getDepartments(context);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.withValues(alpha: 0.05),
                ),
              ),
            ),
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: WelcomeCard(),
                ),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HomeSectionsHeader(
                    titleKey: "departments",
                    onSeeAllPressed: () {
                      context.push(DepartmentsView.routeName);
                    },
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: isTablet ? 180 : 155,
                  child: BlocBuilder<DepartmentCubit, DepartmentState>(
                    builder: (context, state) {
                      if (state is DepartmentLoading) {
                        return const DepartmentSkeletonList();
                      } else if (state is DepartmentFailure) {
                        return HomeErrorState(
                          errorMessage: state.error,
                          onRetry:
                              () => context
                                  .read<DepartmentCubit>()
                                  .getDepartments(context),
                        );
                      } else if (state is DepartmentSuccess) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.departments.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final department = state.departments[index];
                            return DepartmentCard(
                              department: department,
                              onTap: () {
                                context.push(
                                  DepartmentDetailsView.routeName,
                                  extra: {
                                    "department": department.departmentName,
                                    'departmentId': department.id,
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return HomeErrorState(
                          errorMessage: 'get_department_failure'.tr(),
                          onRetry:
                              () => context
                                  .read<DepartmentCubit>()
                                  .getDepartments(context),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HomeSectionsHeader(
                    titleKey: "top_doctors",
                    onSeeAllPressed: () {
                      context.push(DoctorsView.routeName);
                    },
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: isTablet ? 280 : 240,
                  child: BlocBuilder<DoctorsCubit, DoctorsState>(
                    builder: (context, state) {
                      if (state is DoctorsLoading) {
                        return const DoctorsSkeletonList();
                      } else if (state is DoctorsFailure) {
                        return HomeErrorState(
                          errorMessage: state.error,
                          onRetry:
                              () => context.read<DoctorsCubit>().getDoctors(),
                        );
                      } else if (state is DoctorsSuccess) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.doctors.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 18),
                          itemBuilder: (context, index) {
                            final doctor = state.doctors[index];
                            return DoctorCardInHome(
                              index: index,
                              doctor: doctor,
                              onTap: () {
                                context.push(
                                  DoctorDetailsView.routeName,
                                  extra: {
                                    'doctor': doctor,
                                    'image': Assets.doctorsImages[index],
                                  },
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return HomeErrorState(
                          errorMessage: 'get_doctors_failure'.tr(),
                          onRetry:
                              () => context.read<DoctorsCubit>().getDoctors(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
