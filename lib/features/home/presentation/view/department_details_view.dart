import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_app_bar.dart';
import 'package:medicore_app/core/widget/custom_scroll_widget.dart';
import 'package:medicore_app/core/widget/custom_shimer.dart';
import 'package:medicore_app/features/home/presentation/view/doctor_details_view.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/doctor_card_in_department.dart';
import 'package:medicore_app/features/home/presentation/view_model/department_details_cubit/department_details_cubit.dart';

class DepartmentDetailsView extends StatelessWidget {
  static const routeName = '/departmenDetails';

  const DepartmentDetailsView({
    super.key,
    required this.department,
    required this.departmentId,
  });
  final String department;
  final int departmentId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DepartmentDetailsCubit()..getDoctorsInDepartment(departmentId),
      child: Scaffold(
        appBar: CustomAppBar(title: department, isMainBar: false),
        backgroundColor: getIt<ThemeProvider>().themeData.primaryColorLight,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: CustomScrollWidget(
            onRefresh: () {
              context.read<DepartmentDetailsCubit>().getDoctorsInDepartment(
                departmentId,
              );
              return Future.delayed(const Duration(seconds: 1));
            },
            child: BlocBuilder<DepartmentDetailsCubit, DepartmentDetailsState>(
              builder: (context, state) {
                if (state is DepartmentDetailsLoading) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const CustomShimer();
                    },
                  );
                } else if (state is DepartmentDetailsFailure) {
                  return Center(
                    child: Text(state.error, style: TextStyles.notes),
                  );
                } else if (state is DepartmentDetailsSuccess) {
                  return ListView.builder(
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = state.doctors[index];
                      final doctorName =
                          '${doctor.user.firstName} ${doctor.user.lastName}';
                      final doctorImage = doctor.user.imagePath;
                      return DoctorCardInDepartment(
                        name: doctorName,
                        department: department,
                        rating: doctor.rate ?? 3,
                        imageUrl: doctorImage,
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
                  return Center(
                    child: Text(
                      'get_doctors_failure'.tr(),
                      style: TextStyles.notes,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
