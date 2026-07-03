import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/home/presentation/view/department_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/department_card.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_home.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/welcome_card.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_cubit/department_cubit.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctors_cubit/doctors_cubit.dart';

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

    return CustomScrollWidget(
      onRefresh: () {
        context.read<DoctorsCubit>().getDoctors();
        context.read<DepartmentCubit>().getDepartments(context);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: WelcomeCard(),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HomeSectionsHeader(
                titleKey: "departments",
                onSeeAllPressed: () {
                  context.push(DepartmentsView.routeName);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: isTablet ? 170 : 145,
              child: BlocBuilder<DepartmentCubit, DepartmentState>(
                builder: (context, state) {
                  if (state is DepartmentLoading) {
                    return const DepartmentSkeletonList();
                  } else if (state is DepartmentFailure) {
                    return HomeErrorState(
                      errorMessage: state.error,
                      onRetry:
                          () => context.read<DepartmentCubit>().getDepartments(
                            context,
                          ),
                    );
                  } else if (state is DepartmentSuccess) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.departments.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
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
                          () => context.read<DepartmentCubit>().getDepartments(
                            context,
                          ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HomeSectionsHeader(
                titleKey: "top_doctors",
                onSeeAllPressed: () {
                  context.push(DoctorsView.routeName);
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: isTablet ? 260 : 220,
              child: BlocBuilder<DoctorsCubit, DoctorsState>(
                builder: (context, state) {
                  if (state is DoctorsLoading) {
                    return const DoctorsSkeletonList();
                  } else if (state is DoctorsFailure) {
                    return HomeErrorState(
                      errorMessage: state.error,
                      onRetry: () => context.read<DoctorsCubit>().getDoctors(),
                    );
                  } else if (state is DoctorsSuccess) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.doctors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final doctor = state.doctors[index];
                        return DoctorCardInHome(
                          doctor: doctor,
                          onTap: () {
                            context.push(
                              DoctorDetailsView.routeName,
                              extra: {'doctor': doctor},
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return HomeErrorState(
                      errorMessage: 'get_doctors_failure'.tr(),
                      onRetry: () => context.read<DoctorsCubit>().getDoctors(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
