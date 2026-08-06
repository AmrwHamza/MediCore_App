import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/core/helper_function/app_cache_service.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/appointments/data/models/appointments_model.dart';
import 'package:medicore_app/features/appointments/data/models/hive/hive_appointments_local_storge.dart';
import 'package:medicore_app/features/appointments/data/models/hive/hive_appointments_model.dart';
import 'package:medicore_app/features/appointments/data/models/patient_appointment_info_model.dart';
import 'package:medicore_app/features/appointments/data/models/patient_appointment_model.dart';
import 'package:medicore_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:medicore_app/features/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:medicore_app/features/appointments/domain/repos/appointments_repo.dart';

import '../models/privew_model.dart';
import '../models/uploaded_analysis_file.dart';
import '../models/appointment_types.dart';

class AppointmentsRepoImpl implements AppointmentsRepo {
  @override
  Future<Either<Failure, AppointmentsEntity>> getAppointments() async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getAppointments',
    );
    return response.fold((failure) => Left(failure), (data) async {
      final appointments = AppointmentsModel.fromJson(data);
      final cached = [
        ...appointments.data.acceptedPatient,
        ...appointments.data.waitingPatient,
      ].map(_toHiveModel).toList();
      if (cached.isNotEmpty) {
        await getIt<AppointmentsLocalDataSourceImpl>().cacheAppointments(cached);
      }
      return Right(appointments);
    });
  }

  @override
  Future<Either<Failure, List<PatientAppointmentEntity>>>
  getCachedAppointments() async {
    try {
      final cached = await getIt<AppointmentsLocalDataSourceImpl>()
          .getCachedAppointments();
      if (cached.isEmpty) {
        return const Left(
          CacheFailure(message: 'No cached appointments'),
        );
      }
      return Right(cached.map(_fromHiveModel).toList());
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to load cached appointments'),
      );
    }
  }

  HiveAppointmentModel _toHiveModel(PatientAppointmentEntity entity) {
    return HiveAppointmentModel(
      id: entity.id,
      patientId: entity.patientId,
      doctorId: entity.doctorId,
      departmentId: entity.departmentId,
      appointmentDate: entity.appointmentDate,
      appointmentStatus: entity.appointmentStatus,
      status: fromAppointmentTypesToApiString(entity.status),
      enter: 0,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  PatientAppointmentEntity _fromHiveModel(HiveAppointmentModel model) {
    return PatientAppointmentModel(
      id: model.id,
      patientId: model.patientId,
      doctorId: model.doctorId,
      departmentId: model.departmentId,
      appointmentDate: model.appointmentDate,
      appointmentStatus: model.appointmentStatus,
      status: fromStringToAppointmentTypes(model.status),
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      appointmentInfo: PatientAppointmentInfoModel(
        patientName: '',
        patientImage: null,
        doctorName: '',
        gender: '',
      ),
      isChild: false,
    );
  }

  @override
  Future<Either<Failure, PrivewResponseModel>> getPrivews() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getPreviews');
    return response.fold((failure) async {
      final cached = await getIt<AppCacheService>().get(
        _previewsCacheKey,
        allowStale: true,
      );
      if (cached == null) return Left(failure);
      return Right(PrivewResponseModel.fromJson(cached));
    }, (data) async {
      await getIt<AppCacheService>().put(_previewsCacheKey, data);
      return Right(PrivewResponseModel.fromJson(data));
    });
  }

  static const String _previewsCacheKey = 'getPreviews';
  
  @override
  Future<Either<Failure, String>> deleteAppointment({required int appointmentId})async {
    final response = await getIt<Api>().deleteWithAuth(endPoint: 'deleteAppointment/$appointmentId',data:{});
    return response.fold((failure) => Left(failure), (data) {
      return Right('delete_appointment_success'.tr());
    });
  }

  @override
  Future<Either<Failure, UploadedAnalysisFile?>> uploadMedicalAnalysis({
    required int previewId,
    required File file,
    void Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      final fileName = file.path.split('\\').last.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response = await getIt<Api>().postWithAuth(
        endPoint: 'postMedicalAnalysis/$previewId',
        data: formData,
        isMultipart: true,
        onSendProgress: onSendProgress,
      );
      return response.fold(
        (failure) => Left(failure),
        (data) => Right(_readUploadedFile(data, fallbackName: fileName)),
      );
    } catch (e) {
      return const Left(UnknownFailure(message: 'Upload failed'));
    }
  }

  static const String _analysisCachePrefix = 'analysis_upload_';

  @override
  Future<UploadedAnalysisFile?> getCachedAnalysis({
    required int previewId,
  }) async {
    final json = await getIt<AppCacheService>().get(
      _analysisCachePrefix + previewId.toString(),
      allowStale: true,
    );
    if (json == null) return null;
    return UploadedAnalysisFile.fromJson(json);
  }

  @override
  Future<void> cacheAnalysis({
    required int previewId,
    required UploadedAnalysisFile file,
  }) async {
    await getIt<AppCacheService>().put(
      _analysisCachePrefix + previewId.toString(),
      file.toJson(),
    );
  }

  UploadedAnalysisFile? _readUploadedFile(
    Map<String, dynamic> data, {
    required String fallbackName,
  }) {
    final body = data['data'];
    String? fileUrl;
    String? fileName;

    if (body is Map) {
      final map = body.cast<String, dynamic>();
      fileUrl = _firstNonEmptyValue(map, const [
        'file_url',
        'fileUrl',
        'url',
        'path',
        'file_path',
        'analysis_file',
        'file',
      ]);
      fileName = _firstNonEmptyValue(map, const [
        'file_name',
        'fileName',
        'original_name',
        'name',
      ]);
    } else if (body is String && body.trim().isNotEmpty) {
      if (body.contains('/') || body.contains('\\') || body.contains('.')) {
        fileUrl = body;
      }
    }

    if (fileUrl == null && fileName == null) return null;

    return UploadedAnalysisFile(
      fileName:
          (fileName?.isNotEmpty ?? false)
              ? fileName!
              : UploadedAnalysisFile.fileNameFromPath(fileUrl ?? fallbackName),
      fileUrl: fileUrl,
      uploadedAt: DateTime.now(),
    );
  }

  String? _firstNonEmptyValue(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is String && value.trim().isNotEmpty) return value;
    }
    return null;
  }
}
