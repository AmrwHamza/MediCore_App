import 'package:dartz/dartz.dart';
import 'package:medicore_app/core/utils/errors/failure.dart';
import 'package:medicore_app/features/payment/data/models/payment_response_model.dart';

import '../../../../core/helper_function/get_it_service.dart';
import '../../../../core/utils/api_services.dart';
import '../../domain/repos/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  @override
  Future<Either<Failure, PaymentModel>> addPaymentMethods({
    required String phoneNumber,
    required String paymentMethod,
  }) async {
    final response = await getIt<Api>().postWithAuth(
      endPoint: 'postNewPayment',
      data: {'phone_number': phoneNumber, 'company_name': paymentMethod},
    );

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (data) {
        return Right(PaymentModel.fromJson(data['data']));
      },
    );
  }

  @override
  Future<Either<Failure, PaymentResponseModel>> getMyPaymentsMethods() async {
    final response = await getIt<Api>().getWithAuth(endPoint: 'getPayments');
    return response.fold(
      (failure) {
        return Left(failure);
      },
      (json) {
        return Right(PaymentResponseModel.fromJson(json));
      },
    );
  }
}
