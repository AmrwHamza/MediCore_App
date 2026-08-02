import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/features/doctors/presentation/views/widgets/doctor_card.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/department_details_loading_list.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_details_cubit/department_details_cubit.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_lottie.dart';
import '../../../../core/widget/lottie_state.dart';

class DepartmentDetailsView extends StatelessWidget {
  static const routeName = '/departmenDetails';

  final String department;
  final int departmentId;

  const DepartmentDetailsView({
    super.key,
    required this.department,
    required this.departmentId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    return BlocProvider(
      create:
          (context) =>
              DepartmentDetailsCubit()..getDoctorsInDepartment(departmentId),
      child: Scaffold(
        appBar: CustomAppBar(title: department, isMainBar: false),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Builder(
          builder: (context) {
            return CustomScrollWidget(
              onRefresh: () {
                context.read<DepartmentDetailsCubit>().getDoctorsInDepartment(
                  departmentId,
                );
                return Future.delayed(const Duration(seconds: 1));
              },
              child:
                  BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
                    builder: (context, state) {
                      if (state is DepartmentDetailsLoading) {
                        return const DepartmentDetailsLoadingList();
                      } else if (state is DepartmentDetailsFailure) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(state.error, style: TextStyles.notes),
                          ),
                        );
                      } else if (state is DepartmentDetailsSuccess) {
                        if (state.doctors.isEmpty) {
                          return Center(
                            child: LottieState(
                              asset: AppLottie.emptySearchState,
                              message: 'no_doctors_in_dept'.tr(),
                              height: 150.h,
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          itemCount: state.doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = state.doctors[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: DoctorCard(
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
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              'get_doctors_failure'.tr(),
                              style: TextStyles.notes,
                            ),
                          ),
                        );
                      }
                    },
                  ),
            );
          },
        ),
      ),
    );
  }
}
