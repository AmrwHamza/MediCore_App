import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';

import 'appointments_data_model.dart';

class AppointmentsModel extends AppointmentsEntity {
  AppointmentsModel({
    required super.message,
    required AppointmentsDataModel data,
  }) : super(data: data);

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      message: json['message'],
      data: AppointmentsDataModel.fromJson(json['data']),
    );
  }
}
