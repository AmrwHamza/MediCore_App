import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../data/models/payment_response_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, PaymentModel>> addPaymentMethods({
    required String phoneNumber,
    required String paymentMethod,
  });

  Future<Either<Failure, PaymentResponseModel>> getMyPaymentsMethods();
}
