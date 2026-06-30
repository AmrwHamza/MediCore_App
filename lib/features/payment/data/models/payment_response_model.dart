import '../../domain/entities/payment_entity.dart';
import 'payment_method_model.dart';

class PaymentResponseModel {
  final String message;
  final List<PaymentModel> paymentsModel;

  PaymentResponseModel({required this.message, required this.paymentsModel});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      message: json['message'],
      paymentsModel:
          (json['data'] as List).map((e) => PaymentModel.fromJson(e)).toList(),
    );
  }
}

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required super.id,
    required super.userId,
    required super.phoneNumber,
    required super.companyName,
    required super.balance,
    required super.createdAt,
    required super.updatedAt,
    required super.paymentType,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      userId: json['user_id'],
      phoneNumber: json['phone_number'],
      companyName: json['company_name'],
      balance: json['balance'],
      paymentType: PaymentMethodModel.getPaymentType(json['company_name']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
