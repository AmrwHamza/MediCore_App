import 'package:medicore_app/features/book_appointment/domain/entities/book_appointment_entity.dart';

class BookAppointmentModel extends BookAppointmentEntity {
  BookAppointmentModel({required super.message});

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) =>
      BookAppointmentModel(message: json['message']);
}
