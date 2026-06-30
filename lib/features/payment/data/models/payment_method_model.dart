class PaymentMethodModel {
  final int id;
  final String title;
  final String value;

  PaymentMethodModel({
    required this.id,
    required this.title,
    required this.value,
  });

  static final List<PaymentMethodModel> providers = [
    PaymentMethodModel(id: 1, title: 'Syriatel Cash', value: 'syriatel'),
    PaymentMethodModel(id: 2, title: 'MTN Cash', value: 'mtn'),
  ];
}
