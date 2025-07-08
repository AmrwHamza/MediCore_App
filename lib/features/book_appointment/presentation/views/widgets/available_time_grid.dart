import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/theme/theme_provider.dart';

class AvailableTimesGrid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().themeData;

    final startTime = const TimeOfDay(hour: 9, minute: 0);
    final endTime = const TimeOfDay(hour: 16, minute: 0);

    List<TimeOfDay> timeSlots = [];
    TimeOfDay current = startTime;

    while (_timeOfDayBefore(current, endTime)) {
      timeSlots.add(current);
      current = _addMinutes(current, 30);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: timeSlots.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final time = timeSlots[index];
          final isSelected =
              selectedTime != null &&
              time.hour == selectedTime!.hour &&
              time.minute == selectedTime!.minute;

          final timeText = time.format(context);
          final textColor = isSelected ? Colors.white : theme.canvasColor;
          final bgColor =
              isSelected
                  ? KPrimaryColor.withAlpha((0.8 * 255).round())
                  : Colors.white;

          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: InkWell(
                onTap: () => onTimeSelected(time),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.black.withAlpha((0.2 * 255).round()),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      timeText,
                      style: TextStyle(
                        color: textColor,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
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

  bool _timeOfDayBefore(TimeOfDay a, TimeOfDay b) {
    return a.hour < b.hour || (a.hour == b.hour && a.minute < b.minute);
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutesToAdd) {
    final totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    final newHour = totalMinutes ~/ 60;
    final newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }
}
