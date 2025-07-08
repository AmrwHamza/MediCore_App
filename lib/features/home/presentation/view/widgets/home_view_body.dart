import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/features/home/presentation/view/department_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_home.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_cubit/department_cubit.dart';
import 'package:medicore_app/features/home/presentation/view_model/doctors_cubit/doctors_cubit.dart';

import 'department_card.dart';
import 'welcome_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollWidget(
      onRefresh: () {
        context.read<DoctorsCubit>().getDoctors();
        context.read<DepartmentCubit>().getDepartments(context);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeCard(),
                const SizedBox(height: 24),

                Text(
                  "departments".tr(),
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: screenWidth / 2.9,
                  child: BlocBuilder<DepartmentCubit, DepartmentState>(
                    builder: (context, state) {
                      if (state is DepartmentLoading) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          separatorBuilder: (_, __) => const SizedBox(width: 6),
                          itemBuilder:
                              (_, __) => CustomShimer(width: screenWidth / 8),
                        );
                      } else if (state is DepartmentFailure) {
                        return Center(
                          child: Text(state.error, style: TextStyles.notes),
                        );
                      } else if (state is DepartmentSuccess) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.departments.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final department = state.departments[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: DepartmentCard(
                                title: department.departmentName,
                                imageUrl: department.image,
                                onTap: () {
                                  context.push(
                                    DepartmentDetailsView.routeName,
                                    extra: {
                                      "department": department.departmentName,
                                      'departmentId': department.id,
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('get_department_failure'.tr()),
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 32),
                Text(
                  "top_doctors".tr(),
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: screenWidth / 2.1,
                  child: BlocBuilder<DoctorsCubit, DoctorsState>(
                    builder: (context, state) {
                      if (state is DoctorsLoading) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => const SizedBox(width: 6),
                          itemCount: 4,
                          itemBuilder:
                              (_, __) => CustomShimer(width: screenWidth / 5),
                        );
                      } else if (state is DoctorsFailure) {
                        return Center(
                          child: Text(state.error, style: TextStyles.notes),
                        );
                      } else if (state is DoctorsSuccess) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = state.doctors[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: DoctorCardInHome(
                                name: 'dr'.tr() + '${doctor.user.firstName}',
                                department:
                                    doctor.department != null
                                        ? doctor.department!.name
                                        : '',
                                rating: doctor.rate ?? 0.0,
                                imageUrl: doctor.user.imagePath,
                                onTap: () {
                                  context.push(
                                    DoctorDetailsView.routeName,
                                    extra: {'doctor': doctor},
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('get_doctors_failure'.tr()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
