import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/department_cubit/department_book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/department_card.dart';

class DepartmentSection extends StatelessWidget {
  const DepartmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DepartmentBookAppointmentCubit,
      DepartmentBookAppointmentState
    >(
      listener: (context, state) {
        if (state is GetDepartmentFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, departmentState) {
        if (departmentState is DepartmentsLoading) {
          return const Center(child: SpinKitThreeBounce(color: KOrange));
        } else if (departmentState is GetDepartmentsSuccess) {
          final departments = departmentState.departments;
          final selectedDepartmentId =
              context.watch<BookAppointmentCubit>().selectedDepartmentId;

          return SizedBox(
            height: MediaQuery.of(context).size.width / 3,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: departments.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final department = departments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DepartmentCard(
                    title: department.departmentName,
                    imageUrl: department.image,
                    isSelected: selectedDepartmentId == department.id,
                    onTap: () {
                      final bookCubit = context.read<BookAppointmentCubit>();
                      bookCubit.setSelectedDepartmentId(department.id);

                      context
                          .read<DoctorBookAppointmentCubit>()
                          .getDoctorsInDepartment(department.id);
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text('get_department_failure'.tr()));
        }
      },
    );
  }
}
