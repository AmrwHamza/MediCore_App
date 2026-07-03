import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';

import '../../../../core/helper_function/get_it_service.dart';
import '../../../../core/utils/api_services.dart';
import '../../domain/repos/drawer_repo.dart';

class DrawerRepoImpl implements DrawerRepo {
  @override
  Future<Either<Failure, String>> addProfileImage({required File image}) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    final response = await getIt<Api>().postWithAuth(
      endPoint: 'uploadImagesForPatientProfile',
      data: formData,
      isMultipart: true,
    );

    return response.fold(Left.new, (data) => Right(data['data']));
  }

  @override
  Future<Either<Failure, String?>> getProfileImage() async {
    final response = await getIt<Api>().getWithAuth(
      endPoint: 'getProfileImage',
    );

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        return Right(data['data']);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteProfileImage() async {
    final response = await getIt<Api>().deleteWithAuth(
      endPoint: 'deleteProfileImage',
      data: null,
    );
    return response.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        return Right(data['data']);
      },
    );
  }
}
