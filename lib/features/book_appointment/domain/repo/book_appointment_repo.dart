import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/book_appointment/data/model/get_symptoms_model.dart';
import 'package:medicore_app/features/book_appointment/domain/entities/analyse_symptoms_entity.dart';
import 'package:medicore_app/features/book_appointment/domain/entities/book_appointment_entity.dart';

abstract class BookAppointmentRepo {
  Future<Either<Failure, BookAppointmentEntity>> bookAppointment({
    required String date,
    required int doctorId,
    int? sonId,
  });

  Future<Either<Failure,GetSymptomsModel>> getSymptoms({required String lang});

  Future<Either<Failure, AnalyseSymptomsEntity>> analyseSymptoms(
    List<String> selectedSymptoms,
  );
}
