abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No Internet connection',
    super.statusCode,
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Connection timeout',
    super.statusCode,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Unknown error happened',
    super.statusCode,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Invalid data provided',
    super.statusCode,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to cache departments: ',
    super.statusCode,
  });
}
