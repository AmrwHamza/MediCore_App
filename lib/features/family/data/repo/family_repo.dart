import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/helper_function/get_it_service.dart';
import 'package:medicore_app/core/utils/api_services.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/onboarding_medical_info/data/models/child_model.dart';
import 'package:medicore_app/features/onboarding_medical_info/domain/entities/childs_entity.dart';

class FamilyRepo {
  Future<Either<Failure, ChildsEntity>> getChilds() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getChilds');
    return response.fold((failure) => Left(failure), (data) {
      final childs = ChildsModel.fromJson(data);
      return Right(childs);
    });
  }
}
