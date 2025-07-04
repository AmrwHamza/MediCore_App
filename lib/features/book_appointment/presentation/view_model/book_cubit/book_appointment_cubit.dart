import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medicore_app/features/book_appointment/data/repo/book_appointment_repo_impl.dart';

part 'book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit() : super(BookAppointmentInitial());

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedDoctorId;
  int? selectedDepartmentId;

  void setSelectedDepartmentId(int id) {
    selectedDepartmentId = id;
    selectedDoctorId = null;
    emit(DepartmentSelected(id));
  }

  void setSelectedDoctorId(int id) {
    selectedDoctorId = id;
    emit(DoctorSelected(id));
  }



  void setSelectedDate(DateTime date) {
    selectedDate = date;
    emit(DateSelected(date));
  }

  void setSelectedTime(TimeOfDay? time) {
    selectedTime = time;
    if (time != null) {
      emit(TimeSelected(time));
    }
  }

  Future<void> bookAppointment({required int doctorId, int? sonId}) async {
    if (selectedDate == null || selectedTime == null) {
      emit(BookAppointmentFailure(error: 'please_select_date_and_time'.tr()));
      return;
    }

    final fullDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final formattedDateTime = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(fullDateTime);

    emit(BookAppointmentLoading());

    final response = await BookAppointmentRepoImpl().bookAppointment(
      date: formattedDateTime,
      doctorId: doctorId,
      sonId: sonId,
    );

    response.fold(
      (failure) => emit(BookAppointmentFailure(error: failure.message)),
      (data) => emit(BookAppointmentSuccess(message: data.message)),
    );
  }
}
