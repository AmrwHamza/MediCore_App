import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medicore_app/constants.dart';
import 'package:medicore_app/core/helper/shared_pref.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';

class Api {
  late final Dio dio;
  final lang = Intl.getCurrentLocale().split('_').first;

  Api() {
    final options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'ngrok-skip-browser-warning': 'true',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);
    dio.interceptors.add(dioLoggerInterceptor);
  }

  Future<Either<Failure, Map<String, dynamic>>> post({
    required endPoint,
    required data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.post(
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

  Future<Either<Failure, Map<String, dynamic>>> postWithAuth({
    required String endPoint,
    required dynamic data,
    bool isMultipart = false,
    void Function(int sent, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final token = await SharedPrefHelper.getString(SharedPrefKeys.userToken);

      if (token.isEmpty) {
        return const Left(
          ValidationFailure(message: '====Token is missing or invalid===='),
        );
      }

      final options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await dio.post(
        endPoint,
        data: isMultipart ? data : {...?data, 'lang': lang},
        options: options,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (_) {
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
          ValidationFailure(message: 'Token is missing or invalid'),
        );
      }

      final mergedQuery = {...?queryParameters, 'lang': lang};
      final options = Options(
        headers: {'Authorization': 'Bearer $token'},
        responseType: responseType,
      );
      final response = await dio.get(
        '$endPoint',
        queryParameters: mergedQuery,
        options: options,
      );
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
          ValidationFailure(message: '====Token is missing or invalid===='),
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
          ValidationFailure(message: '====Token is missing or invalid===='),
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
    final statusCode = dioError.response?.statusCode;
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutFailure(statusCode: statusCode);
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: 'Server response timeout',
          statusCode: statusCode,
        );
      case DioExceptionType.sendTimeout:
        return TimeoutFailure(
          message: 'Request timeout',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final errorMessage = getErrorMessage(dioError.response?.data);
        return ServerFailure(
          message: 'Error $statusCode,$errorMessage',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return UnknownFailure(
          message: 'Request was canceled',
          statusCode: statusCode,
        );
      case DioExceptionType.unknown:
        return UnknownFailure(
          message: 'no internet connection',
          statusCode: statusCode,
        );
      case DioExceptionType.badCertificate:
        return ValidationFailure(
          message: 'bad Certificate',
          statusCode: statusCode,
        );
      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'connection error',
          statusCode: statusCode,
        );
      case DioExceptionType.transformTimeout:
        throw UnimplementedError();
    }
  }

  String getErrorMessage(data) {
    if (data is String) return data;
    if (data is Map && data.containsKey('message')) {
      final message = data['message'];
      if (message is String) return message;
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

  final dioLoggerInterceptor = InterceptorsWrapper(
    onRequest: (RequestOptions options, handler) {

      var data;

      if (options.data.runtimeType.toString() == 'FormData') {
        data = {'fields': options.data?.fields, 'files': options.data?.files};
      } else {
        data = options.data;
      }
      String headers = "";
      options.headers.forEach((key, value) {
        headers += "| $key: $value";
      });

      log(
        "┌------------------------------------------------------------------------------",
      );
      log('''| [DIO] Request: ${options.method} ${options.uri}
| $data
| Headers:\n$headers''');
      log(
        "├------------------------------------------------------------------------------",
      );
      handler.next(options);
    },
    onResponse: (Response response, handler) async {

      log(response.data.toString());
      log(
        "└------------------------------------------------------------------------------",
      );
      handler.next(response);

    },
    onError: (DioException error, handler) async {
      log("| [DIO] Error: ${error.error}: ${error.response.toString()}");
      log(
        "└------------------------------------------------------------------------------",
      );
      handler.next(error);
    },
  );
}
