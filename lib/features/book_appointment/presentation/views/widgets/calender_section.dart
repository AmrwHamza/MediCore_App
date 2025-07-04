import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/available_time_grid.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderSection extends StatelessWidget {
  const CalenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getIt<ThemeProvider>().themeData;

    return BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
      listener: (context, state) {
        if (state is BookAppointmentFailure) {
          CustomSnackbar.show(
            context,
            message: state.error,
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookAppointmentCubit>();
        final selectedDoctorId = cubit.selectedDoctorId;
        final selectedDate = cubit.selectedDate;
        final selectedTime = cubit.selectedTime;

        return (selectedDoctorId != null)
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'select_day'.tr(),
                  style: TextStyles.H2.copyWith(color: theme.canvasColor),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: selectedDate ?? DateTime.now(),
                    selectedDayPredicate:
                        (day) =>
                            selectedDate != null &&
                            isSameDay(selectedDate, day),
                    onDaySelected: (selected, _) {
                      cubit.setSelectedDate(selected);
                      cubit.setSelectedTime(null);
                    },
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      decoration: const BoxDecoration(
                        color: KPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      titleTextStyle: TextStyle(
                        color: theme.cardColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: theme.cardColor,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: theme.cardColor,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: const BoxDecoration(
                        color: KOrange,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: KPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: const TextStyle(color: Colors.white),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      defaultTextStyle: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      weekendTextStyle: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                ),

                if (selectedDate != null) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'select_time'.tr(),
                      style: TextStyles.H2.copyWith(color: theme.canvasColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AvailableTimesGrid(
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    onTimeSelected: (p0) => cubit.setSelectedTime(p0),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                ],
              ],
            )
            : const SizedBox.shrink();
      },
    );
  }
}
