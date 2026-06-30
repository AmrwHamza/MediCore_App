import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/department_cubit/department_book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/doctor_cubit/doctor_book_appointment_cubit.dart';
import 'package:medicore_app/features/home/presentation/view/widgets/department_card.dart';

class DepartmentSection extends StatefulWidget {
  const DepartmentSection({super.key});

  @override
  State<DepartmentSection> createState() => _DepartmentSectionState();
}

class _DepartmentSectionState extends State<DepartmentSection> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSelected(int index, int totalItems) {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final target = (maxScroll / (totalItems - 1)) * index;
    _scrollController.animateTo(
      target.clamp(0.0, maxScroll),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

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
          return const Center(
            child: SpinKitThreeBounce(color: KPrimaryColor, size: 30),
          );
        } else if (departmentState is GetDepartmentsSuccess) {
          final departments = departmentState.departments;
          final selectedDepartmentId =
              context.watch<BookAppointmentCubit>().selectedDepartmentId;

          return SizedBox(
            height: MediaQuery.of(context).size.width / 2.9,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              itemCount: departments.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final department = departments[index];
                final isSelected = selectedDepartmentId == department.id;

                if (isSelected && _scrollController.hasClients) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToSelected(index, departments.length);
                  });
                }

                return AnimatedScale(
                  scale: isSelected ? 1.04 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutBack,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: KPrimaryColor.withAlpha(40),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                              : [],
                    ),
                    child: DepartmentCard(
                      department: department,
                      isSelected: isSelected,
                      onTap: () {
                        final bookCubit = context.read<BookAppointmentCubit>();
                        bookCubit.setSelectedDepartmentId(department.id);
                        context
                            .read<DoctorBookAppointmentCubit>()
                            .getDoctorsInDepartment(department.id);
                        _scrollToSelected(index, departments.length);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text(
              'get_department_failure'.tr(),
              style: TextStyle(color: theme.disabledColor),
            ),
          );
        }
      },
    );
  }
}
