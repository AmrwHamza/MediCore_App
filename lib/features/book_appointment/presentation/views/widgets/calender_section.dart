import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/text_styles.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';
import 'package:medicore_app/core/widget/custom_snack_bar.dart';
import 'package:medicore_app/features/book_appointment/presentation/view_model/book_cubit/book_appointment_cubit.dart';
import 'package:medicore_app/features/book_appointment/presentation/views/widgets/available_time_grid.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderSection extends StatefulWidget {
  const CalenderSection({super.key});

  @override
  State<CalenderSection> createState() => _CalenderSectionState();
}

class _CalenderSectionState extends State<CalenderSection> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTimeSection() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

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

        if (selectedDoctorId == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_day'.tr(),
                style: TextStyles.H2.copyWith(
                  color: theme.canvasColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withAlpha(isDark ? 15 : 30),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color:
                        isDark
                            ? Colors.white12
                            : theme.shadowColor.withAlpha(15),
                    width: 1,
                  ),
                ),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: selectedDate ?? DateTime.now(),
                  selectedDayPredicate:
                      (day) =>
                          selectedDate != null && isSameDay(selectedDate, day),
                  onDaySelected: (selected, _) {
                    cubit.setSelectedDate(selected);
                    cubit.setSelectedTime(null);
                    _scrollToTimeSection();
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? Colors.white.withAlpha(15)
                              : KPrimaryColor.withAlpha(20),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    titleTextStyle: TextStyle(
                      color: isDark ? Colors.white : KPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: isDark ? Colors.white : KPrimaryColor,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.white : KPrimaryColor,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: KPrimaryColor.withAlpha(50),
                      shape: BoxShape.circle,
                      border: Border.all(color: KPrimaryColor, width: 1.5),
                    ),
                    todayTextStyle: const TextStyle(
                      color: KPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: KPrimaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: KPrimaryColor,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    defaultTextStyle: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.w500,
                    ),
                    weekendTextStyle: TextStyle(
                      color: theme.textTheme.bodyMedium?.color?.withAlpha(180),
                    ),
                    outsideDaysVisible: false,
                  ),
                ),
              ),
              if (selectedDate != null) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: KPrimaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'select_time'.tr(),
                        style: TextStyles.H2.copyWith(
                          color: theme.canvasColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AvailableTimesGrid(
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  onTimeSelected: (p0) => cubit.setSelectedTime(p0),
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
    );
  }
}
