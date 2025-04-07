import 'package:equatable/equatable.dart';
import 'package:isp_app/features/user_management/domain/customer.dart';

class Payment extends Equatable {
  final String orderId;
  final int grossAmount;
  final Customer customer;
  final String paymentType;
  final MitraBank bankName;

  const Payment({
    required this.orderId,
    required this.grossAmount,
    required this.customer,
    required this.paymentType,
    required this.bankName,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'grossAmount': grossAmount,
      'paymentType': paymentType,
      'customer': customer.toMap(),
      'bankName': bankName.name,
    };
  }

  @override
  List<Object?> get props => [
        orderId,
        grossAmount,
        paymentType,
        bankName,
        customer,
      ];
}

enum MitraBank {
  bni,
  bri,
  bca,
  mandiri,
}
