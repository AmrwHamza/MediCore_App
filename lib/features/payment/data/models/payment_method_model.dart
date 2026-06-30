import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/app_images.dart';

enum PaymentType { syriatel, mtn, sham_cash }

class PaymentMethodModel {
  final int id;
  final String title;
  final String value;
  final PaymentType paymentType;

  PaymentMethodModel({
    required this.id,
    required this.title,
    required this.value,
    required this.paymentType,
  });

  static final List<PaymentMethodModel> providers = [
    PaymentMethodModel(
      id: 1,
      title: 'Syriatel_Cash_title'.tr(),
      value: 'syriatel',
      paymentType: PaymentType.syriatel,
    ),
    PaymentMethodModel(
      id: 2,
      title: 'MTN_Cash_title'.tr(),
      value: 'mtn',
      paymentType: PaymentType.mtn,
    ),
    PaymentMethodModel(
      id: 2,
      title: 'Sham_Cash_title'.tr(),
      value: 'sham_cash',
      paymentType: PaymentType.sham_cash,
    ),
  ];

  static String getPaymentTitle(PaymentType payment) {
    switch (payment) {
      case PaymentType.syriatel:
        return 'Syriatel_Cash_title'.tr();
      case PaymentType.mtn:
        return 'MTN_Cash_title'.tr();
      case PaymentType.sham_cash:
        return 'Sham_Cash_title'.tr();
    }
  }

  static String getPaymentDesc(PaymentType payment) {
    switch (payment) {
      case PaymentType.syriatel:
        return 'syriatel_cash_desc'.tr();
      case PaymentType.mtn:
        return 'cash_mtn_desc'.tr();
      case PaymentType.sham_cash:
        return 'sham_cash_desc'.tr();
    }
  }

  static String getPaymentLogo(PaymentType payment) {
    switch (payment) {
      case PaymentType.syriatel:
        return Assets.syriatelLogo;
      case PaymentType.mtn:
        return Assets.mtnLogo;
      case PaymentType.sham_cash:
        return Assets.shamCashLogo;
    }
  }

  static PaymentType getPaymentType(String payment) {
    switch (payment) {
      case 'Syriatel_Cash':
        return PaymentType.syriatel;
      case 'mtn':
        return PaymentType.mtn;
      case 'sham_cash':
        return PaymentType.sham_cash;
      default:
        return PaymentType.syriatel;
    }
  }
}
