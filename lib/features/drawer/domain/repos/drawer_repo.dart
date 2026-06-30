import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';

abstract class DrawerRepo {
  Future<Either<Failure, String?>> getProfileImage();
  Future<Either<Failure, String>> addProfileImage({required File image});
  Future<Either<Failure, void>> deleteProfileImage();
}
