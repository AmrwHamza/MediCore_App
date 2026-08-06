import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';

import '../../data/models/privew_model.dart';
import '../../data/models/uploaded_analysis_file.dart';

abstract class AppointmentsRepo {
  Future<Either<Failure, AppointmentsEntity>> getAppointments();
  Future<Either<Failure, List<PatientAppointmentEntity>>>
  getCachedAppointments();
  Future<Either<Failure, PrivewResponseModel>> getPrivews();
  Future<Either<Failure, String>> deleteAppointment({required int appointmentId});
  Future<Either<Failure, UploadedAnalysisFile?>> uploadMedicalAnalysis({
    required int previewId,
    required File file,
    void Function(int sent, int total)? onSendProgress,
  });
  Future<UploadedAnalysisFile?> getCachedAnalysis({required int previewId});
  Future<void> cacheAnalysis({
    required int previewId,
    required UploadedAnalysisFile file,
  });
}
