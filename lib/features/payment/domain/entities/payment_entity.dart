import '../../data/models/payment_method_model.dart';

class PaymentEntity {
  final int id;
  final int userId;
  final String phoneNumber;
  final String companyName;
  final num? balance;
  final PaymentType paymentType;
  final String createdAt;
  final String updatedAt;

  PaymentEntity({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    required this.companyName,
    required this.balance,
    required this.paymentType,
    required this.createdAt,
    required this.updatedAt,
  });
}
