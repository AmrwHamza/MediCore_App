import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/features/appointments/presentation/view_model/cubit/delete_appointment_cubit.dart';

import '../../view_model/appointments_cubit/appointments_cubit.dart';

class DeleteAppointmentButton extends StatelessWidget {
  const DeleteAppointmentButton({super.key, required this.appointmentId});

  final int appointmentId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAppointmentCubit, DeleteAppointmentState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (message) async {

            await context.read<AppointmentsCubit>().getAppointments();
          },
          error: (errorMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage), backgroundColor: KError),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: (id) => id == appointmentId,
          orElse: () => false,
        );

        return InkWell(
          onTap:
              isLoading
                  ? null
                  : () {
                    _showDeleteDialog(context);
                  },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: KError.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.05),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child:
                isLoading
                    ? SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(KError),
                      ),
                    )
                    : const Icon(Icons.delete, color: KError),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext parentContext) {
    showGeneralDialog(
      context: parentContext,

      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.15),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (dialogContext, _, _) {
        final deleteCubit = parentContext.read<DeleteAppointmentCubit>();

        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: const SizedBox.expand(),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 330.w,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Theme.of(parentContext).cardColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 32.r,
                        backgroundColor: KError.withValues(alpha: .1),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: KError,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        "delete_dialog_title".tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(parentContext).canvasColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "delete_dialog_description".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text(
                                "delete_dialog_cancel".tr(),
                                style: TextStyle(
                                  color: Theme.of(parentContext).canvasColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: KError,
                              ),
                              onPressed: () {
                                Navigator.of(dialogContext).pop();

                                deleteCubit.deleteAppointment(
                                  appointmentId: appointmentId,
                                );
                              },
                              child: Text(
                                "delete_dialog_confirm".tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: .9, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
