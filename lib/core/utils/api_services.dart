import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';

class Api {
  late Dio dio;

  Api() {
    {
      final BaseOptions options = BaseOptions(
        baseUrl: baseurl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'ngrok-skip-browser-warning': 'true'},
      );

      dio = Dio(options);
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> post({
    required endPoint,
    required data,
    Map<String, String>? headers,
  }) async {
    try {
      print('$endPoint=====eeee');
      print('$data=====3333');
      print('$headers=====444');

      final response = await dio.post(
        '$endPoint',
        data: data,
        options: Options(headers: headers),
      );

      print('${response.data}=====response data==');
      print('${response.statusCode}=status code======');
      print('${response.statusMessage}=statue messaage======');

      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> postWithAuth({
    required endPoint,
    required data,
  }) async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token.isEmpty) {
        return const Left(
          ValidationFailure('====Token is missing or invalid===='),
        );
      }
      final options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await dio.post(
        '$endPoint',
        data: data,
        options: options,
      );

      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> get({
    required endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        '$endPoint',
        queryParameters: queryParameters ?? {},
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, dynamic>> getWithAuth({
    required endPoint,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseType,
  }) async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token.isEmpty) {
        return const Left(
          ValidationFailure('====Token is missing or invalid===='),
        );
      }
      final options = Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: responseType,
      );

      final response = await dio.get(
        '$endPoint',
        queryParameters: queryParameters ?? {},
        options: options,
      );
      // print(response.data.toString());
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> delete({
    required endPoint,
    required data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.delete(
        '$endPoint',
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteWithAuth({
    required endPoint,
    required data,
  }) async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token.isEmpty) {
        return const Left(
          ValidationFailure('====Token is missing or invalid===='),
        );
      }
      final options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await dio.delete(
        '$endPoint',
        data: data,
        options: options,
      );

      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> put({
    required endPoint,
    data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.put(
        '$endPoint',
        data: data,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> putWithAuth({
    required endPoint,
    Map<String, dynamic>? queryParameters,
    data,
  }) async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);
      if (token.isEmpty) {
        return const Left(
          ValidationFailure('====Token is missing or invalid===='),
        );
      }
      final options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await dio.put(
        '$endPoint',
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (dioException) {
      return Left(handleDioError(dioException));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Failure handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const TimeoutFailure();
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure('Server response timeout');

      case DioExceptionType.sendTimeout:
        return const TimeoutFailure('Request timeout');
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final errorMessage = getErrorMessage(dioError.response?.data);
        return ServerFailure('Error $statusCode,$errorMessage');
      case DioExceptionType.cancel:
        return const UnknownFailure('Request was canceled');
      case DioExceptionType.unknown:
        return const UnknownFailure('no internet connection');
      case DioExceptionType.badCertificate:
        return const ValidationFailure('bad Certificate');
      case DioExceptionType.connectionError:
        return const NetworkFailure('connectio error');
      default:
        return UnknownFailure(dioError.message ?? 'Unexpected error');
    }
  }

  String getErrorMessage(data) {
    if (data is String) {
      return data;
    }
    if (data is Map && data.containsKey('message')) {
      final message = data['message'];
      if (message is String) {
        return message;
      }
      if (message is Map) {
        final List<String> errors = [];
        for (var entry in message.entries) {
          final key = entry.key;
          final value = entry.value;
          if (value is List) {
            errors.add('$key: ${value.join(", ")}');
          } else {
            errors.add('$key: $value');
          }
        }
        return errors.join('\n');
      }
    }
    if (data is List) return data.join(', ');

    return 'Unknown error occurred';
  }
}
