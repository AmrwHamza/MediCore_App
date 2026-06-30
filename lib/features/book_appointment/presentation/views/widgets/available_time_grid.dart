import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class AvailableTimesGrid extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const AvailableTimesGrid({
    required this.selectedDate,
    this.selectedTime,
    required this.onTimeSelected,
    super.key,
  });

  @override
  State<AvailableTimesGrid> createState() => _AvailableTimesGridState();
}

class _AvailableTimesGridState extends State<AvailableTimesGrid> {
  late final List<TimeOfDay> _timeSlots;

  @override
  void initState() {
    super.initState();
    _timeSlots = _generateTimeSlots();
  }

  List<TimeOfDay> _generateTimeSlots() {
    const startTime = TimeOfDay(hour: 9, minute: 0);
    const endTime = TimeOfDay(hour: 16, minute: 0);
    final List<TimeOfDay> slots = [];
    TimeOfDay current = startTime;

    while (_timeOfDayBefore(current, endTime)) {
      slots.add(current);
      current = _addMinutes(current, 30);
    }
    return slots;
  }

  bool _timeOfDayBefore(TimeOfDay a, TimeOfDay b) {
    return a.hour < b.hour || (a.hour == b.hour && a.minute < b.minute);
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutesToAdd) {
    final totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _timeSlots.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2.3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final time = _timeSlots[index];
          final isSelected =
              widget.selectedTime != null &&
              time.hour == widget.selectedTime!.hour &&
              time.minute == widget.selectedTime!.minute;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient:
                  isSelected
                      ? LinearGradient(
                        colors: [KPrimaryColor, KPrimaryColor.withAlpha(200)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                      : LinearGradient(
                        colors:
                            isDark
                                ? [
                                  Colors.white.withAlpha(20),
                                  Colors.white.withAlpha(5),
                                ]
                                : [
                                  Colors.white,
                                  theme.scaffoldBackgroundColor.withAlpha(150),
                                ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              boxShadow: [
                BoxShadow(
                  color:
                      isSelected
                          ? KPrimaryColor.withAlpha(90)
                          : theme.shadowColor.withAlpha(isDark ? 10 : 20),
                  blurRadius: isSelected ? 12 : 6,
                  offset: isSelected ? const Offset(0, 4) : const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: InkWell(
                  onTap: () => widget.onTimeSelected(time),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color:
                            isSelected
                                ? Colors.white.withAlpha(100)
                                : (isDark
                                    ? Colors.white12
                                    : theme.shadowColor.withAlpha(25)),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        time.format(context),
                        style: TextStyle(
                          color: isSelected ? Colors.white : theme.canvasColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
