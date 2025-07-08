import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/book_appointment/data/model/analyse_symptoms_model.dart';
import 'package:medicore_app/features/book_appointment/data/model/book_appointment_model.dart';
import 'package:medicore_app/features/book_appointment/data/model/get_symptoms_model.dart';
import 'package:medicore_app/features/book_appointment/domain/entities/analyse_symptoms_entity.dart';
import 'package:medicore_app/features/book_appointment/domain/entities/book_appointment_entity.dart';
import 'package:medicore_app/features/book_appointment/domain/repo/book_appointment_repo.dart';

class BookAppointmentRepoImpl implements BookAppointmentRepo {
  @override
  Future<Either<Failure, BookAppointmentEntity>> bookAppointment({
    required String date,
    required int doctorId,
    int? sonId,
  }) async {
    final Response = await getIt<Api>().postWithAuth(
      endPoint: 'bookAppointment/$doctorId',
      data: {'appointment_date': date, 'son_id': sonId},
    );
    return Response.fold((failure) => Left(failure), (data) {
      final message = BookAppointmentModel.fromJson(data);
      return Right(message);
    });
  }

  @override
  Future<Either<Failure, AnalyseSymptomsEntity>> analyseSymptoms(
    List<String> selectedSymptoms,
  ) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'symptom/analyze',
      data: {'symptoms': selectedSymptoms},
    );
    return response.fold((failure) => Left(failure), (data) {
      final symptoms = AnalyseSymptomsModel.fromJson(data);
      return Right(symptoms);
    });
  }

  @override
  Future<Either<Failure, GetSymptomsModel>> getSymptoms({
    required String lang,
  }) async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getSymbtoms',
      queryParameters: {'lang': lang},
    );
    return response.fold((failure) => Left(failure), (data) {
      final symptoms = GetSymptomsModel.fromJson(data);
      return Right(symptoms);
    });
  }
}
